//SPDX-License-Identifer: UNLICENSED
pragma solidity ^0.8.3;

import "@solady/src/tokens/ERC20.sol";
import "@solady/src/utils/SafeTransferLib.sol";
import "@solady/src/utils/ReentrancyGuard.sol";
import "@solady/src/auth/Ownable.sol";

contract Vault is ReentrancyGuard, Ownable {
    error ZeroAssets(); //keccak256 0x1f2a2005cb66a8e145327e8814e243a0996aec9bfe1e15a495778b1236dbd485
    error InsufficientShares(); //keccak26 0x399965675cfec4301cbe5ec24fb407575c5a7e4f40d219532068c8e5b35040f9
    error ZeroShares(); //keccak256 0x9811e0c7eeca2ee0fa751e2e19d78682ad689ea04816cfe0cf1c5863234abd3f

    event Deposit(address indexed user, uint asset, uint shares);
    event Withdraw(address indexed user, uint256 assets, uint256 shares);
    event RewardAdded(uint amout);

    using SafeTransferLib for address;

    ERC20 private immutable ASSET;
    uint256 private totalShares;

    mapping(address account => uint256 shares) private sharesOf;

    constructor(ERC20 _asset) {
        ASSET = _asset;
    }

    function getAssetBalance() internal view returns (uint256) {
        return ASSET.balanceOf(address(this));
    }
 

    function getAsset() external view returns (address) {
        return address(ASSET);
    }


    function getAssetDecimals() internal view returns (uint256) {
        return ASSET.decimals();
    }

    function getAssetName() external view returns (string memory) {
        try ASSET.name() returns (string memory name) {
            if (bytes(name).length == 0) return "Unknown Asset"; //Because exists ERC20 that returns bytes
            return name;
        } catch {
            return "Unknown Asset";
        }
    }

    function currentRatio() external view returns (uint ratio) {
      assembly {
        let _totalShares := sload(totalShares.slot)
        if iszero(_totalShares) {
          ratio := 1000000000000000000
          mstore(0x00, ratio)
          return(0x00, 32)
        }
      }
      if (ratio != 0) return ratio;

      uint totalAsset = getAssetBalance();

      ratio = totalAsset * 1e18/totalShares;
    }

    function _convertToShares(
        uint asset
    ) internal view returns (uint shares) {
        uint _totalAssets = getAssetBalance();

        if (totalShares == 0) {
            return asset;
        }

        return (asset * totalShares) / _totalAssets;
    }

    function _convertToAssets(
        uint  shares
    ) internal view returns (uint asset) {
        uint  _totalAssets = getAssetBalance();

        if (totalShares == 0) {
            return 0;
        }

        return (shares * _totalAssets) / totalShares;
    }

    function assetOf(address user) external view returns(uint totalAssetUser, uint totalSharesUser) {
      totalSharesUser = sharesOf[user];

      totalAssetUser = _convertToAssets(totalSharesUser);
    } 



    function deposit(uint assets) external nonReentrant returns (uint shares) {
        assembly {
            if iszero(assets) {
                mstore(0x00, 0x36dbd485)
                revert(0x1c, 0x04)
            }
        }

        shares = _convertToShares(assets);
        if (shares == 0) revert ZeroShares();

        address from = msg.sender;
        sharesOf[from] += shares;
        totalShares += shares;

        address to = address(this);
        address(ASSET).safeTransferFrom(from, to, assets);

        emit Deposit(from, assets, shares);
    }

    function withdraw(uint shares) public nonReentrant returns (uint assets) {
        assembly {
            if iszero(shares) {
                mstore(0x00, 0x234abd3f)
                revert(0x1c, 0x04)
            }
        }
        address from = msg.sender;

        uint userShares = sharesOf[from];
        if (userShares < shares) revert InsufficientShares();

        uint256 totalAsset = getAssetBalance();

        assets = _convertToAssets(shares);
        if (assets == 0) revert ZeroAssets();

        sharesOf[from] = userShares - shares;
        totalShares -= shares;

        address(ASSET).safeTransfer(from, assets);

        emit Withdraw(from, shares, assets);
    }

    function withdrawAll() external onlyOwner returns (uint assets) {
        uint allShares = sharesOf[msg.sender];

        assets = withdraw(allShares);
    }

    function previewDeposit(uint assets) external view returns(uint) {
      return _convertToShares(assets);
    }

    function reviewWithdraw(uint shares) external view returns(uint) {
      return _convertToAssets(shares);
    }

    function addReward(uint amount) external onlyOwner nonReentrant {
      assembly {
        if iszero(amount) {
          mstore(0x00, 0x36dbd485)
          revert(0x1c, 0x04)
        }

        let  _totalShares := sload(totalShares.slot)
        if iszero(_totalShares) {
          mstore(0x00, 0x234abd3f)
          revert(0x1c, 0x04)
        }
      }

      address(ASSET).safeTransferFrom(msg.sender, address(this), amount);

      emit RewardAdded(amount);
    }

    receive() external payable {}

    fallback() external payable {}
}

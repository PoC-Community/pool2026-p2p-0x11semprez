//SPDX-License-Identifer: UNLICENSED
pragma solidity ^0.8.3;

import "@solady/src/tokens/ERC20.sol";
import "@solady/src/utils/SafeTransferLib.sol";
import "@solady/src/utils/ReentrancyGuard.sol";
import "@solady/src/auth/Ownable.sol";

contract Vault is SafeTransferLib, ReentrancyGuard, Ownable {
    error ZeroAssets(); //keccak256 0x1f2a2005cb66a8e145327e8814e243a0996aec9bfe1e15a495778b1236dbd485
    error InsufficientShares(); //keccak26 0x399965675cfec4301cbe5ec24fb407575c5a7e4f40d219532068c8e5b35040f9
    error ZeroShares(); //keccak256 0x9811e0c7eeca2ee0fa751e2e19d78682ad689ea04816cfe0cf1c5863234abd3f

    event Deposit(address indexed user, uint asset, uint shares);
    event Withdraw(address indexed user, uint256 assets, uint256 shares);

    using SafeTransferLib for address;

    ERC20 private immutable ASSET;
    uint256 private totalShares;

    mapping(address account => uint256 shares) private sharesOf;

    constructor(ERC20 _asset) {
        ASSET = _asset;
    }

    function getAsset() external view returns (address) {
        return address(ASSET);
    }

    function getAssetBalance() internal view returns (uint256) {
        return ASSET.balanceOf(address(this));
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

    function _convertToShares(
        uint256 asset
    ) internal view returns (uint256 shares) {
        uint256 _totalAssets = getAssetBalance();

        if (totalShares == 0) {
            return asset;
        }

        return (asset * totalShares) / _totalAssets;
    }

    function _convertToAssets(
        uint256 shares
    ) internal view returns (uint256 asset) {
        uint256 _totalAssets = getAssetBalance();

        if (totalShares == 0) {
            return 0;
        }

        return (shares * _totalAssets) / totalShares;
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
        shares += totalShares;

        address to = address(this);
        assets.SafeTransferFrom(from, to, assets);

        emit Deposit(from, assets, shares);
    }

    function withdraw(
        uint shares
    ) internal ReentrancyGuard returns (uint assets) {
        if (shares == 0) revert ZeroShares();
        address from = msg.sender;

        uint userShares = sharesOf[from];
        if (userShares < shares) revert InsufficientShares();

        uint256 totalAsset = getAssetBalance();

        assets = _convertToAssets(shares, totalAsset, totalShares);
        if (assets == 0) revert ZeroAssets();

        sharesOf[from] = userShares - shares;
        totalShares -= shares;

        assets.SafeTransferFrom(from, assets);

        emit Withdraw(from, shares, assets);
    }

    function withdrawAll() external returns (uint assets) {
        uint allShares = sharesOf[msg.sender];

        assets = withdraw(allShares);
    }

    function previewDeposit(uint assets) external view {}

    function reviewWithdraw(uint shares) external view {}

    receive() external payable {}

    fallback() external payable {}
}

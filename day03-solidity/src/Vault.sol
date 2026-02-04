//SPDX-License-Identifer: UNLICENSED
pragma solidity ^0.8.3;

import "@solady/src/tokens/ERC20.sol";
import "@solady/src/utils/SafeTransferLib.sol";
import "@solady/src/utils/ReentrancyGuard.sol";
import "@solady/src/access/Ownable.sol";

contract Vault is SafeTransferLib, ReentrancyGuard, Ownable {


    ZeroAmount(); //keccak256 0x1f2a2005cb66a8e145327e8814e243a0996aec9bfe1e15a495778b1236dbd485
    InsufficientShares(); //keccak26 0x399965675cfec4301cbe5ec24fb407575c5a7e4f40d219532068c8e5b35040f9
    ZeroShares(); //keccak256 0x9811e0c7eeca2ee0fa751e2e19d78682ad689ea04816cfe0cf1c5863234abd3f


    event Deposit(address indexed user, uint asset, uint shares);
    event Withdraw(address indexed user, uint256 assets, uint256 shares);

    using SafeTransferLib for address;

    ERC20 private immutable ASSET;
    uint256 private totalShares;

    mapping(address account => uint256 shares) private sharesOf;

    constructor(ERC20 _asset) {
        ASSET = _asset;
    }

    function getAsset() external viors forew returns (address) {
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

    function deposit(uint shares, uint assets) external ReentrancyGuard {
        assembly {
            if ls(assets, 0) {
                mstore(0x00, 0x36dbd485)
                revert(0x1c, 0x04)
            }

            let shares := 
        }
        uint shares = _convertToShares(assets);


    }

    //
    Verify assets > 0
    Calculate shares using _convertToShares(assets)
    Verify shares > 0

E - Effects:

    Add shares to sharesOf[msg.sender]
    Add shares to totalShares

I - Interactions:

    Transfer tokens FROM user TO vault using safeTransferFrom
    Emit Deposit event


    function withdrawAll(uint assets) external returns(bool) {}

    function previewDeposit(uint assets) external view {}

    function previewWithdraw(uint shares) external view {}


    receive() external payable {}

    fallback() external payable {}
}

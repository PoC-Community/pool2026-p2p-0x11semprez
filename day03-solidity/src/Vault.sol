//SPDX-License-Identifer: UNLICENSED
pragma solidity ^0.8.3;

import "@solady/src/tokens/ERC20.sol";
import "@solady/src/utils/SafeTransferLib.sol";

contract Vault {
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

    function _convertToShares(uint256 asset) internal view returns (uint256 shares) {
        uint256 _totalAssets = getAssetBalance();

        if (totalShares == 0) {
            return asset;
        }

        return (asset * totalShares) / _totalAssets;
    }

    function _convertToAssets(uint256 shares) internal view returns (uint256 asset) {
        uint256 _totalAssets = getAssetBalance();

        if (totalShares == 0) {
            return 0;
        }

        return (shares * _totalAssets) / totalShares;
    }

    receive() external payable {}

    fallback() external payable {}
}

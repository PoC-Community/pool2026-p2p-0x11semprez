// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";
import "@solady/src/tokens/ERC20.sol";

contract VaultTestHelper is Vault {
    constructor() Vault(ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48)) {}

    function convertToSharesExt(
        uint256 assets
    ) external view returns (uint256) {
        return _convertToShares(assets);
    }

    function convertToAssetsExt(
        uint256 shares
    ) external view returns (uint256) {
        return _convertToAssets(shares);
    }

    function getAssetDecimalsExt() external view returns (uint256) {
        return getAssetDecimals();
    }
}

contract VaultTest is Test {
    Vault public vault;
    VaultTestHelper public helper;
    ERC20 USDC = ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

    function setUp() public {
        vault = new Vault(USDC);
        helper = new VaultTestHelper();
    }

    function test_FreeMoney() public {
        uint256 assets = 2345;

        uint256 shares = helper.convertToSharesExt(assets);
        uint256 assetsBack = helper.convertToAssetsExt(shares);

        assertLe(assetsBack, assets);
    }

    function test_getName() public {
        string memory name = vault.getAssetName();
        assertEq(name, "USD Coin");
    }

    function test_getDecimals() public {
        uint256 decimals = helper.getAssetDecimalsExt();
        assertEq(decimals, 6);
    }
}

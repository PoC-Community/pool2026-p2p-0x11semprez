// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import "forge-std/console2.sol";
import {Vault} from "../src/Vault.sol";
import "@solady/src/tokens/ERC20.sol";

contract VaultTestHelper is Vault {
    constructor() Vault(ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48)) {}

    function convertToSharesExt(
        uint assets
    ) external view returns (uint) {
        return _convertToShares(assets);
    }

    function convertToAssetsExt(
        uint shares
    ) external view returns (uint) {
        return _convertToAssets(shares);
    }

    function getAssetDecimalsExt() external view returns (uint) {
        return getAssetDecimals();
    }

    function _getAssetBalance() public view returns(uint) {
      return getAssetBalance();
    }
}

contract VaultTest is Test {
    Vault public vault;
    VaultTestHelper public helper;
    ERC20 USDC = ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    address Alice;

    function setUp() public {
        vault = new Vault(USDC);
        helper = new VaultTestHelper();
        Alice = makeAddr("Alice");
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


    function test_deposit() public {
      uint  depositAmount = 1000;
      uint  rewardAmount = 100;

      vm.startPrank(Alice);


      vault.deposit(depositAmount);


      (uint assetsAlice, uint sharesAlice) = vault.assetOf(Alice);
      console2.log("After deposit - shares:", sharesAlice);
      console2.log("After deposit - assets:", assetsAlice);
      console2.log("Contract asset balance:", helper._getAssetBalance());

      vault.addReward(rewardAmount);


      (assetsAlice, sharesAlice) = vault.assetOf(Alice);
      console2.log("After reward - shares:", sharesAlice);
      console2.log("After reward - assets:", assetsAlice);
      console2.log("Contract asset balance:", helper._getAssetBalance());

      vault.withdrawAll();

      (assetsAlice, sharesAlice) = vault.assetOf(Alice);
      console2.log("After withdrawAll - shares:", sharesAlice);
      console2.log("After withdrawAll - assets:", assetsAlice);

      assertEq(sharesAlice, 0);
      assertEq(assetsAlice, 0);

      vm.stopPrank();
    }
}

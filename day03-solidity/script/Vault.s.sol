// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/Vault.sol";
import "@solady/src/tokens/ERC20.sol";

contract VaultScript is Script {
    Vault public vault;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        vault = new Vault(ERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48));
        console.log("Contract Deployed at:", address(vault));

        vm.stopBroadcast();
    }
}

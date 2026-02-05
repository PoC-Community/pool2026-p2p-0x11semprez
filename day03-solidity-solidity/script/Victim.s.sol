// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Victim} from "../src/Victim.sol";

contract VictimScript is Script {
    Victim public victim;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        victim = new Victim();

        vm.stopBroadcast();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Test} from "forge-std/Test.sol";
import {SmartContract} from "../src/SmartContract.sol";

contract testSmartContract is Test {
    SmartContract public smartcontract;

    function setUp() public {
        smartcontract = new SmartContract();
    }

    function testgetPocIsWhat() public {
        string memory actual = smartcontract.getPoCIsWhat();
        string memory expected = "Poc is the best community in the world";
        assertEq(actual, expected);
    }
}

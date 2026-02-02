// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import {Test} from "forge-std/Test.sol";
import {SmartContract} from "../src/SmartContract.sol";

contract TestSmartContract is Test {
    SmartContract public smartcontract;

    function setUp() public {
        smartcontract = new SmartContract();
    }

    function testgetPocIsWhat() public {
        assertEq(
            smartcontract.getPoCIsWhat(),
            "Poc is the best community in the world"
        );
    }

    function testStruct() public {
        (
            string memory firstName,
            string memory lastName,
            uint8 age,
            string memory city,
            bool role
        ) = smartcontract.getStruct();

        assertEq(firstName, "John");
        assertEq(lastName, "Doe");
        assertEq(age, 30);
        assertEq(city, "Paris");
        assertEq(role, true);
    }

    function testaddGetHalfAnswerOfLife() public {
        bool ok = smartcontract.addGetHalfAnswerOfLife();
        assertTrue(ok);
        assertEq(smartcontract.getHalfAnswerOfLife(), 42);
    }

    function testaddGetHalfAnswerOfLife_revertIfNotOwner() public {
        address attacker = address(0xBEEF);

        vm.prank(attacker);
        vm.expectRevert("Not the owner");
        
        smartcontract.addGetHalfAnswerOfLife();
    }

    function testHashMyMessage() public {
        bytes32 hash = smartcontract.hashMyMessage("hello");
        bytes32 expected = keccak256(abi.encodePacked("hello"));
        assertEq(hash, expected);
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import {Test} from "forge-std/Test.sol";
import {SmartContract} from "../src/SmartContract.sol";

// contract SmartContractHelper is SmartContract {
//     function getAreYouABadPerson() public view returns (string memory) {
//         return _setAreYouABadPerson(true);
//     }
// }
contract testSmartContract is Test {
    SmartContract public smartcontract;
    // SmartContractHelper public smartcontracthelper;

    function setUp() public {
        smartcontract = new SmartContract();
        // smartcontracthelper = new SmartContractHelper();
    }

    // function test_areYouABadPerson() public {
    //     bool actual = smartcontracthelper.getAreYouABadPerson();
    //     string memory expected = "Yes I am";
    //     assertEq(actual, expected);
    // }

    function testgetPocIsWhat() public {
        string memory actual = smartcontract.getPoCIsWhat();
        string memory expected = "Poc is the best community in the world";
        assertEq(actual, expected);
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
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Oracle} from "../src/Counter.sol";

contract OracleTest is Test {
  Oracle public oracle;

  function setUp() public {
    oracle = new Oracle(0x694AA1769357215DE4FAC081bf1f309aDC325306);
  }

  function test_getPrice() public {
    int256 test_price = oracle.getLastestPrice();

    console.log("price:", test_price);
  }
}

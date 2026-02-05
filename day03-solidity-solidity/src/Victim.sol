// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

contract Victim {

  mapping(address user => uint256 balance) public balance;

  function deposit() external payable {
    require(msg.value >= 1 ether,  "Not engouh ETH");
    balance[msg.sender] += msg.value;
  }

  function withdraw(uint amount) external payable {
    require(balance[msg.sender] > amount, "Not enough Money");

    (bool sucess, ) = msg.sender.call{value: amount}("");

    require(sucess ,"not my problem");

    balance[msg.sender] -= amount;
  }

  function getBalanceContract() external returns(uint balanceContract) {
    return address(this).balance;
  }

}

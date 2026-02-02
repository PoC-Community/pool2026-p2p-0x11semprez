// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

interface ISmartContract {
    event BalanceAdded(address indexed user, uint256 indexed amount);
    event BalanceWithdrawn(address indexed user, uint256 indexed amount);

    function getHalfAnswerOfLife() external view returns (uint256);

    function getPoCIsWhat() external view returns (string memory);

    function editMyCity(string calldata _city) external;

    function getMyFullName() external view returns (string memory);

    function addGetHalfAnswerOfLife() external returns (bool);

    function addToBalance() external payable;

    function withdrawFromBalance(uint256 _amount, address to) external;

    function hashMyMessage(
        string calldata _message
    ) external pure returns (bytes32);
}

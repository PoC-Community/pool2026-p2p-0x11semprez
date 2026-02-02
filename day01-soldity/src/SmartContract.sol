//SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.4;

contract SmartContract {
    uint public halfAnswerOfLife = 21;

    address public myEthereumContractAddress = address(this);

    address public myEthereumAddress = msg.sender;

    string public PoCIsWhat = "PoC is good, PoC is life.";

    bool internal _areYouABadPerson = false;

    int private immutable _youAreACheater = -42;

    bytes32 public constant WHO_IS_THE_BEST =
        bytes32(uint256(uint160(0x2279aF075411bB2F5821C7413367278E9B4aC655)));

    mapping(string exam => uint256 grade) public myGrades;

    string[5] public myPhoneNumber;

    enum roleEnum {
        STUDENT,
        TEACHER
    }

    struct informations {
        string firstName;
        string lastName;
        uint8 age;
        string city;
        bool role;
    }

    informations public myInformations;

    function getHalfAnswerOfLife() public view returns (string memory) {
        return "No idea";
    }

    function _getMyEthereumContractAddress() internal view returns (address) {
        return address(this);
    }

    function getPoCIsWhat() external view returns (string memory) {
        return "Poc is the best community in the world";
    }

    function _setAreYouABadPerson(
        bool _value
    ) internal returns (string memory) {
        if (_value = true) {
            return "Yes I am";
        } else {
            return "No I am not";
        }
    }
}

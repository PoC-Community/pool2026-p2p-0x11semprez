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

    address private owner;

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

    constructor(address _owner) {
        owner = _owner;
        myInformations = informations({
            firstName: "John",
            lastName: "Doe",
            age: 30,
            city: "Paris",
            role: true
        });
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function sensitiveAction(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function getStruct()
        public
        view
        returns (
            string memory firstName,
            string memory lastName,
            uint8 age,
            string memory city,
            bool role
        )
    {
        return (
            myInformations.firstName,
            myInformations.lastName,
            myInformations.age,
            myInformations.city,
            myInformations.role
        );
    }

    function getHalfAnswerOfLife() public view returns (string memory) {
        return 21;
    }

    function addGetHalfAnswerOfLife() external onlyOwner returns (bool) {
        halfAnswerOfLife += 21;
        return true;
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
        if (_value == true) {
            return "Yes I am";
        } else {
            return "No I am not";
        }
    }

    function editMyCity(string calldata _newCity) public {
        myInformations.city = _newCity;
    }

    function getMyFullName() public view returns (string memory) {
        return
            string.concat(myInformations.firstName, "", myInformation.lastName);
    }
}

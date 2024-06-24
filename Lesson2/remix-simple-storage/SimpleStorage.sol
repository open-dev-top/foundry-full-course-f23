// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract SimpleStorage {
    // Basic Types
    // boolean
    bool hasFavoriteNumber = false;

    // uint
    // The myFavoriteNumber gets initialized to 0 if no value is given.
    uint256 myFavoriteNumber; // 0

    // int
    int internal leastFavoriteNumber = -42;

    // string
    string myFavoriteNumberInText = "42";

    // address
    address myAddress = 0xF805636A05Bb396faF9Bb6954F4112d8c8F6B104;

    // bytes
    bytes32 favoriteBytes32 = "cat";

    // uint256[] listOfFavoriteNumbers;
    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    // Person public myGod = Person({favoriteNumber: 42, name: "God"});
    // Person public myCopyGod = Person({favoriteNumber: 42, name: "copyGod"});
    Person[] public listOfPeople; // dynamic array

    mapping(string => uint256) public nameToFavoriteNumber;


    function store(uint256 _myFavoriteNumber) public {
        myFavoriteNumber = _myFavoriteNumber;
        // retrieve(); // This will cost more gas.
    }

    // view, pure
    function retrieve() public view returns(uint256){
        return myFavoriteNumber;
    }

    // calldata, memory, storage
    // memory -- struct, mapping, array(string)
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // _name="cat"; // calldata can not do this.
        
        // Person memory newPerson = Person({name: _name, favoriteNumber: _favoriteNumber});
        // listOfPeople.push(newPerson);
        listOfPeople.push(Person(_favoriteNumber,_name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

// Deploy on the Sepolia Testnet
// Contract Address:
//   0xA28a8cF22cF9558688844f7D7951421d8FE77312

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    // type visibility name
    // SimpleStorage public simpleStorage;
    // SimpleStorage[] public listOfSimpleStorageContracts;
    address[] public listOfSimpleStorageAddresses;

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        // listOfSimpleStorageContracts.push(newSimpleStorageContract);
        listOfSimpleStorageAddresses.push(address(newSimpleStorageContract));
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public{
        // Address
        // SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        SimpleStorage mySimpleStorage = SimpleStorage(listOfSimpleStorageAddresses[_simpleStorageIndex]);

        // ABI -- Application Binary Interface
        mySimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        // SimpleStorage mySimpleStorage = SimpleStorage(listOfSimpleStorageAddresses[_simpleStorageIndex]);
        return (SimpleStorage(listOfSimpleStorageAddresses[_simpleStorageIndex])).retrieve();
    }
}

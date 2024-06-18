// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract SimpleStorage {
    // Basic Types
    // boolean
    bool hasFavoriteNumber = false;

    // uint
    // The favoriteNumber gets initialized to 0 if no value is given.
    uint256 favoriteNumber; // 0

    // int
    int internal leastFavoriteNumber = -42;

    // string
    string favoriteNumberInText = "42";

    // address
    address myAddress = 0xF805636A05Bb396faF9Bb6954F4112d8c8F6B104;

    // bytes
    bytes32 favoriteBytes32 = "cat";


    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
}

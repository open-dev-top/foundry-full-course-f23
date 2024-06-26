// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
    // uint256 public myValue = 1;

    using PriceConverter for uint256;

    uint256 public minimumUsd = 5 * 1e18; // USD * 1e18

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    address public owner;


    constructor() {
        owner = msg.sender;
    }


    modifier onlyOwner() {
        require(msg.sender == owner, "Sender is not owner!");
        _;
    }


    function fund() public payable {
        // myValue = myValue + 2; // Also cost gas when a reverted transaction happened.
        require((msg.value).getConversionRate() >= minimumUsd, "didn't send enough ETH"); // 1e18 = 1 ETH
        
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
 
    function withdraw() public onlyOwner {
        // require(msg.sender == owner, "Sender is not owner!");

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        /*
        // transfer (2300 gas, throws error)
        // msg.sender address
        // payable(msg.sender) payable address
        payable(msg.sender).transfer(address(this).balance); // this refers to the current contract.
    
        // send (2300 gas, returns bool)
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send faied");

        // call (forward all gas or set gas, returns bool)
        */
        (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call faied");
    }
}

// Deploy on the Sepolia Testnet
// Contract Address:
//     0x9c201424327469c1ddAF459A4529e8b4fba29050

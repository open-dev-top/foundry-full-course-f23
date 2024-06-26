// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

// Since Solidity 0.8.4
error NotOwner();

// Gas Usage: 933078
contract FundMe{
    // uint256 public myValue = 1;

    using PriceConverter for uint256;

    // Gas Usage: 910113
    uint256 public constant MINIMUM_USD = 5 * 1e18; // USD * 1e18
    // 2451 gas -- non-constant
    // 351  gas -- constant
    // (2451-351) * 3000000000 = 6,300,000,000,000 Wei

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    // Gas Usage: 882983
    address public immutable i_owner;
    // 2580 gas -- non-immutable
    // 444 gas -- immutable
    // (2580-444) * 3000000000 = 6,408,000,000,000 Wei

    constructor() {
        i_owner = msg.sender;
    }

    // Gas Usage: 854123
    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not i_owner!");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }


    function fund() public payable {
        // myValue = myValue + 2; // Also cost gas when a reverted transaction happened.
        require((msg.value).getConversionRate() >= MINIMUM_USD, "didn't send enough ETH"); // 1e18 = 1 ETH
        
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
 
    function withdraw() public onlyOwner {
        // require(msg.sender == i_owner, "Sender is not i_owner!");

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


    // receive()
    // fallback()
}

// Deploy on the Sepolia Testnet
// Contract Address:
//     0x9c201424327469c1ddAF459A4529e8b4fba29050

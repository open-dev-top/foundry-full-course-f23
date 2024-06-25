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

    function fund() public payable {
        // myValue = myValue + 2; // Also cost gas when a reverted transaction happened.
        require((msg.value).getConversionRate() >= minimumUsd, "didn't send enough ETH"); // 1e18 = 1 ETH
        
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
 
    // function withdraw() public {}

}

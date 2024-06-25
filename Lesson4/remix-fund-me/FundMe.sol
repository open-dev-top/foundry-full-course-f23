// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    // uint256 public myValue = 1;

    uint256 public minimumUsd = 5 * 1e18; // USD * 1e18

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        // myValue = myValue + 2; // Also cost gas when a reverted transaction happened.
        require(getConversionRate(msg.value) >= minimumUsd, "didn't send enough ETH"); // 1e18 = 1 ETH
        
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
 
    // function withdraw() public {}

    function getPrice() public view returns(uint256) {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int price,,,) = priceFeed.latestRoundData();
        
        // ETH        1(.)000000000000000000
        // USD/ETH 3372(.)86431485
        return uint256(price * 1e10); // msg.value has type uint256, uint256(...) is just to match the types of price and msg.value. This is incorrect when price is negative.
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice(); // 3372864314850000000000 USD/ETH * 1e18
        uint256 ethAmountInUsdE36 = (ethAmount * ethPrice); // ETH * USD/ETH * 1e18 * 1e18 = USD * 1e36
        uint256 ethAmountInUsdE18 = ethAmountInUsdE36 / 1e18; // USD * 1e36 / 1e18 = USD * 1e18
        return ethAmountInUsdE18; // No loss of accuracy
    }

    function getVersion() public view returns(uint256) {
        return (AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)).version();
    }
}

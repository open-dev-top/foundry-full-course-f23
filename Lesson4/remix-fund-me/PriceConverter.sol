// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
        function getPrice() internal view returns(uint256) {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int price,,,) = priceFeed.latestRoundData();
        
        // ETH        1(.)000000000000000000
        // USD/ETH 3372(.)86431485
        return uint256(price * 1e10); // msg.value has type uint256, uint256(...) is just to match the types of price and msg.value. This is incorrect when price is negative.
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice(); // 3372864314850000000000 USD/ETH * 1e18
        uint256 ethAmountInUsdE36 = (ethAmount * ethPrice); // ETH * USD/ETH * 1e18 * 1e18 = USD * 1e36
        uint256 ethAmountInUsdE18 = ethAmountInUsdE36 / 1e18; // USD * 1e36 / 1e18 = USD * 1e18
        return ethAmountInUsdE18; // No loss of accuracy
    }

    function getVersion() internal view returns(uint256) {
        return (AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)).version();
    }
}

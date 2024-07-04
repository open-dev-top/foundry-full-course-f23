// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// import {Test} from "../lib/forge-std/src/Test.sol";
import {Test} from "forge-std/Test.sol";

contract FundMeTest is Test {
    uint256 number = 1;

    function setUp() external {
        number = 2;
    }

    function testDemo() public view {
        assertEq(number, 2);
    }
}

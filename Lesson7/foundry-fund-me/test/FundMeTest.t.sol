// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// import {Test} from "../lib/forge-std/src/Test.sol";
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    // uint256 number = 1;
    // function setUp() external {
    //     number = 2;
    // }
    // function testDemo() public view {
    //     console.log(number);
    //     console.log("Hello");
    //     assertEq(number, 2);
    // }

    FundMe fundMe;

    function setUp() external {
        // us → fundMeTest → FundMe
        fundMe = new FundMe();
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        // console.log(fundMe.i_owner());
        // console.log(msg.sender);
        // assertEq(fundMe.i_owner(), msg.sender);

        assertEq(fundMe.i_owner(), address(this));
    }
}

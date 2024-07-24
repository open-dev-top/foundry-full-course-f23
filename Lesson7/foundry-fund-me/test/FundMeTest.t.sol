// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// import {Test} from "../lib/forge-std/src/Test.sol";
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

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

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        // us → fundMeTest → FundMe
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        // us → deployFundMe → FundMe
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        // console.log(fundMe.i_owner());
        // console.log(msg.sender);
        assertEq(fundMe.i_owner(), msg.sender);

        // assertEq(fundMe.i_owner(), address(this));
    }

    // We're going to talk about four different types of tests:
    // 1. Uint
    //    - Testing a specific part of our contract code.
    // 2. Intergration
    //    - Testing multiple different contracts are working correctly together.
    // 3. Forked
    //    - Testing our code on a simulated real environment.
    // 4. Staging
    //    - Testing our code in a real environment that is not prod.

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER); // The next TX will be sent by USER
        fundMe.fund{value: SEND_VALUE}();

        // uint256 amountFunded = fundMe.getAddressToAmountFunded(msg.sender);
        // uint256 amountFunded = fundMe.getAddressToAmountFunded(address(this));
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);

        assertEq(amountFunded, SEND_VALUE);
    }
}

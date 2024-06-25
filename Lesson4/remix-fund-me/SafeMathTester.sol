// SPDX-License-Identifier: MIT
// pragma solidity <=0.7.6;
pragma solidity 0.8.0;

contract SafeMathTester {
    uint8 public bigNumber = 255;
    uint8 public uncheckedBigNumber = 255;

    function add() public {
        bigNumber = bigNumber + 1;
    }

    // unchecked keyword only exist start 0.8.0
    function uncheckedAdd() public {
        unchecked {
            uncheckedBigNumber = uncheckedBigNumber + 1;
        }
    }
}

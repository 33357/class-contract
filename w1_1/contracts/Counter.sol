//  SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint256 public counter;

    constructor() {}

    function count() public {
        counter += 1;
    }

    function set(uint256 x) public {
        counter += x;
    }
}

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Bank {
    mapping(address => uint256) balance;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function withdraw(uint256 amount) external {
        require(balance[msg.sender] <= amount,"Bank: withdraw too much");
        balance[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Bank: may be contract call");
    }

    function run() external {
        require(msg.sender == owner);
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Bank: may be contract call");
    }

    receive() external payable {
        balance[msg.sender] += msg.value;
    }
}

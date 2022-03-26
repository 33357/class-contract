//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Vault {
    using SafeERC20 for IERC20;

    mapping(address => uint256) public balance;
    IERC20 public myToken;

    constructor(address myTokenAddress) {
        myToken = IERC20(myTokenAddress);
    }

    function deposite(uint256 amount) external {
        myToken.safeTransferFrom(msg.sender, address(this), amount);
        balance[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external {
        require(balance[msg.sender] >= amount);
        myToken.safeTransfer(msg.sender, amount);
        balance[msg.sender] -= amount;
    }
}

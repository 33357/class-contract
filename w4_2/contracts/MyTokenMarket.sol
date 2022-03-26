//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20.sol";

contract MyTokenMarket is ERC20 {
    IScore score;

    constructor(address _score) ERC20("MyToken","MyToken"){
        score = IScore(_score);
    }

    function AddLiquidity(uint256 amount) external {
        score.addScore(amount);
    }

    function buyToken(uint256 amount) external {
        score.subScore(amount);
    }
}

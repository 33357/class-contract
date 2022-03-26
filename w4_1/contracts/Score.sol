//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IScore {
    function addScore(uint256 amount) external;

    function subScore(uint256 amount) external;
}

contract Score {
    mapping(address => uint256) score;
    address teacher;

    constructor() {
        teacher = address(new Teacher(address(this)));
    }

    modifier _onlyTeacher() {
        require(msg.sender == teacher, "Score: not teacher");
        _;
    }

    function addScore(uint256 amount) external _onlyTeacher {
        require(score[msg.sender] + amount <= 100, "Score: add too much");
        score[msg.sender] += amount;
    }

    function subScore(uint256 amount) external _onlyTeacher {
        score[msg.sender] -= amount;
    }
}

contract Teacher {
    IScore score;

    constructor(address _score) {
        score = IScore(_score);
    }

    function addScore(uint256 amount) external {
        score.addScore(amount);
    }

    function subScore(uint256 amount) external {
        score.subScore(amount);
    }
}

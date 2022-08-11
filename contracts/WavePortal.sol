// SPDX-Liscence-Identifier: UNLICENSE
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint256) public wavers;

    constructor() {
        console.log("Hello World this is a contract");
    }

    function wave() public {
        totalWaves++;
        console.log("%s waved", msg.sender);
        wavers[msg.sender] = wavers[msg.sender] + 1;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d waves", totalWaves);
        return totalWaves;
    }
}

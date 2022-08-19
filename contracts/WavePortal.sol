// SPDX-Liscence-Identifier: UNLICENSE
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    // struct Wavers{
    //     address waver;
    //     uint256 waves;
    // }
    
    // Wavers[] wavers;
    //store and event for every new wavw
    event NewWave(address indexed from,uint256 timestamp,string message);

    // create a wave struct
    //- a struct is a collection of variables (like objects in js)
    struct Wave{
        address from;
        uint256 timestamp;
        string message;
    }

    // Create an array of waves
    Wave[] waves;
    constructor() {
        console.log("Hello World this is a contract");
    }

    function wave(string memory _message) public {
        totalWaves++;
        // console.log("%s waved", msg.sender);
        console.log("%s waved w/ message %s", msg.sender,_message);

        //store your wave data in the waves array
        waves.push(Wave(msg.sender,block.timestamp,_message));

        //emit the wave event
        emit NewWave(msg.sender,block.timestamp,_message);

        // wavers[msg.sender] = wavers[msg.sender] + 1;
        // wavers.push(Wavers(msg.sender,1));
    }
    // function to get all waves from the array
    function getAllWaves() public view returns(Wave[] memory) {
        return waves;
    }

    // funtion to get total waves
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d waves", totalWaves);
        return totalWaves;
    }
}

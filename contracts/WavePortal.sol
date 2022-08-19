// SPDX-Liscence-Identifier: UNLICENSE
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;
    // struct Wavers{
    //     address waver;
    //     uint256 waves;
    // }

    // Wavers[] wavers;
    //store and event for every new wavw
    event NewWave(address indexed from, uint256 timestamp, string message);

    // create a wave struct
    //- a struct is a collection of variables (like objects in js)
    struct Wave {
        address from;
        uint256 timestamp;
        string message;
    }

    // Create an array of waves
    Wave[] waves;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Hello World this is a contract");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "You can only wave once every 15 minutes"
        );

        //if true then update the last waved at time
        lastWavedAt[msg.sender] = block.timestamp;
        totalWaves++;
        // console.log("%s waved", msg.sender);
        console.log("%s waved w/ message %s", msg.sender, _message);

        //store your wave data in the waves array
        waves.push(Wave(msg.sender, block.timestamp, _message));

        //emit the wave event
        emit NewWave(msg.sender, block.timestamp, _message);

        // generate random number
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);
        // set a prizeAmount
        if (seed < 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether; //equi 0.31$
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more than you have"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw");
        }
        // wavers[msg.sender] = wavers[msg.sender] + 1;
        // wavers.push(Wavers(msg.sender,1));
    }

    // function to get all waves from the array
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    // funtion to get total waves
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d waves", totalWaves);
        return totalWaves;
    }
}

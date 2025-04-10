// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Twitter {
    // mapping twitter to userAddress 
    mapping (address => string) public tweets;

    function createTweet(string memory _tweet) public  {
       tweets[msg.sender] = _tweet;
    }

    function getUserTweet(address _userAddress ) public view returns (string memory) {
        return tweets[_userAddress];
    }
    
}
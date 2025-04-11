// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Twitter {

    uint16 public MAX_TWEET_LENGTH = 100;
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    // define my datatype for tweets 
    struct tweetsType {
        uint256 id;
        address author;
        string content;
        uint likes;
        uint timestemp;
    } 

    // mapping twitter to userAddress 
    mapping (address => tweetsType[]) public tweets;
    


    modifier isOwner(){
        require(owner == msg.sender, "You ane not an Owner.");
        _;
    }

    function changeTweetLength(uint16 length)public isOwner{
        MAX_TWEET_LENGTH = length;
    }

    function createTweet(string memory _tweet) public  {
        tweetsType memory newTweet = tweetsType({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            likes: 0,
            timestemp: block.timestamp
        });
       tweets[msg.sender].push(newTweet);
    }

    function likeTweet(address author, uint256 id) external   {
        require(tweets[author][id].id == id, "Twieet Does not exits");
       tweets[author][id].likes++;
    }

    function unlikeTweet(address author, uint256 id) external   {
        require(tweets[author][id].id == id, "Twieet Does not exits");
        require(tweets[author][id].likes > 0, "Twieet Does not have any likes");
       tweets[author][id].likes--;
    }

    //because we are using mapping so only enter sender.address and get their all tweets.
    function getCurrentUserTweet() public view returns (tweetsType[] memory) {
        return tweets[msg.sender];
    }
}
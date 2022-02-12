// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Mintango is ERC1155, Ownable {
    // tracks the total number of minted tokens
    uint256 private _currentTokenID = 0;

    // cost of minting a token
    uint256 public fee = 100;

    // token reference maps
    mapping(string => uint256) public idmap;
    mapping(uint256 => string) public lookupmap;

    // token properties
    mapping(uint256 => uint256) public wins;
    mapping(uint256 => uint256) public losses;
    mapping(uint256 => uint256) public totalGames;
    mapping(uint256 => uint256) public upVoteCount;
    mapping(uint256 => uint256) public downVoteCount;

    // stores array of addresses that up/down voted for a particular token
    // these are used to prevent double voting
    mapping(uint256 => mapping(address => bool)) public upVoteAddresses;
    mapping(uint256 => mapping(address => bool)) public downVoteAddresses;

    mapping(address => bool) private blacklist;
    mapping(address => bool) private whitelist;

    /**
     * @dev Require msg.sender to not be blacklisted
     */
    modifier noBlacklisters() {
        require(
            !blacklist[msg.sender],
            "Mintango#notBlacklisted: BLACKLISTED_ADDRESSES_ARE_FORBIDDEN"
        );
        _;
    }

    /**
     * @dev Ensure token exists
     */
    modifier tokenExists(uint256 tokenID) {
        require(tokenID > 0, "Mintango#tokenExists: INVALID_TOKEN_ID");
        require(
            tokenID <= _currentTokenID,
            "Mintango#tokenExists: TOKEN_ID_DOES_NOT_EXIST"
        );
        _;
    }

    /**
     * @dev Ensure token exists
     */
    modifier onlyNewVoters(uint256 tokenID) {
        require(
            !upVoteAddresses[tokenID][msg.sender],
            "Mintango#onlyNewVoters: ACCOUNT_ALREADY_UPVOTED"
        );
        require(
            !downVoteAddresses[tokenID][msg.sender],
            "Mintango#onlyNewVoters: ACCOUNT_ALREADY_DOWNVOTED"
        );
        _;
    }

    constructor() ERC1155("https://ipfs.moralis.io:2053/ipfs/{id}") {}

    function addToBlacklist(address _address) public onlyOwner {
        blacklist[_address] = true;
    }

    function addToWhitelist(address _address) public onlyOwner {
        blacklist[_address] = true;
    }

    function mint(string memory cid, bytes memory data) public noBlacklisters {
        // UNCOMMENT BELOW AND ADD PAYABLE TO FUCTION DECLARATION TO ENABLE FEE
        // if (!whitelist[msg.sender]) {
        //      require(msg.value >= fee, "You must pay the fee to mint a token");
        //      msg.sender.transfer(fee);
        // }

        // premint checks then increments the token id
        require(idmap[cid] == 0, "Mintango: This cid already exists");
        _currentTokenID = _currentTokenID + 1;

        // add to reference maps
        idmap[cid] = _currentTokenID;
        lookupmap[_currentTokenID] = cid;

        // initialize token properties
        wins[_currentTokenID] = 0;
        losses[_currentTokenID] = 0;
        totalGames[_currentTokenID] = 0;
        upVoteCount[_currentTokenID] = 0;
        downVoteCount[_currentTokenID] = 0;

        _mint(msg.sender, _currentTokenID, 1, data);
    }

    function upVote(uint256 tokenID)
        public
        noBlacklisters
        onlyNewVoters(tokenID)
        tokenExists(tokenID)
    {
        upVoteAddresses[tokenID][msg.sender] = true;
        upVoteCount[tokenID] = upVoteCount[tokenID] + 1;
    }

    function downVote(uint256 tokenID)
        public
        noBlacklisters
        onlyNewVoters(tokenID)
        tokenExists(tokenID)
    {
        downVoteAddresses[tokenID][msg.sender] = true;
        downVoteCount[tokenID] = downVoteCount[tokenID] + 1;
    }

    function recordGame(
        uint256 tokenID,
        address winner,
        address loser
    ) public noBlacklisters tokenExists(tokenID) {
        totalGames[tokenID] = totalGames[tokenID] + 1;
        if (winner == msg.sender) {
            wins[tokenID] = wins[tokenID] + 1;
        } else {
            losses[tokenID] = losses[tokenID] + 1;
        }
    }
}

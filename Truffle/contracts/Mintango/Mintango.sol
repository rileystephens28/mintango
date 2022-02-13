// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title An ERC1155 contract for minting user generated tokens.
 * @author Riley Stephens
 * @notice This contract is intended to reference it's metadata on IPFS.
 * @dev Implements black/whitelisting and on-chain ratings.
 */
contract Mintango is ERC1155, Ownable {
    // tracks the total number of minted tokens
    uint256 private _currentTokenID = 0;

    // cost of minting a token
    uint256 public fee = 100;

    // token reference maps
    mapping(string => uint256) public idmap;
    mapping(uint256 => string) public lookupmap;

    // token properties
    mapping(uint256 => uint256) public upVoteCount;
    mapping(uint256 => uint256) public downVoteCount;

    // stores array of addresses that up/down voted for a particular token
    // these are used to prevent double voting
    mapping(uint256 => mapping(address => bool)) public upVoteAddresses;
    mapping(uint256 => mapping(address => bool)) public downVoteAddresses;

    mapping(address => bool) private blacklist;
    mapping(address => bool) private whitelist;

    /**
     * @notice Require msg.sender to not be blacklisted
     * @dev Reverts if msg.sender is blacklisted
     */
    modifier noBlacklisters() {
        require(
            !blacklist[msg.sender],
            "Mintango#notBlacklisted: BLACKLISTED_ADDRESSES_ARE_FORBIDDEN"
        );
        _;
    }

    /**
     * @notice Ensure token has been minted by contract
     * @dev Reverts if token does not exist
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
     * @notice Ensure msg.sender has not voted on token
     * @dev Reverts if msg.send has already voted on token
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

    /**
     * @notice Prevent account from minting tokens and voting
     * @param _address The address to add to the blacklist
     */
    function addToBlacklist(address _address) public onlyOwner {
        blacklist[_address] = true;
    }

    /**
     * @notice Allow account to mint tokens and vote again
     * @param _address The address to remove from the blacklist
     */
    function removeFromBlacklist(address _address) public onlyOwner {
        blacklist[_address] = false;
    }

    /**
     * @notice Exempt account from paying fee when minting tokens
     * @param _address The address to add to the whitelist
     */
    function addToWhitelist(address _address) public onlyOwner {
        blacklist[_address] = true;
    }

    /**
     * @notice Ensure account pays fee when minting tokens again
     * @param _address The address to remove from the whitelist
     */
    function removeFromWhitelist(address _address) public onlyOwner {
        blacklist[_address] = false;
    }

    /**
     * @notice Mint a new NFT for the msg.sender
     * @param cid The CID of the token metadata on IPFS
     * @param data Additional data to be stored with the token
     */
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
        upVoteCount[_currentTokenID] = 0;
        downVoteCount[_currentTokenID] = 0;

        _mint(msg.sender, _currentTokenID, 1, data);
    }

    /**
     * @notice Count msg.sender's upvote for a token
     * @dev Only allows one vote per account per token
     * @param tokenID The ID of the token to upvote
     */
    function upVote(uint256 tokenID)
        public
        noBlacklisters
        onlyNewVoters(tokenID)
        tokenExists(tokenID)
    {
        upVoteAddresses[tokenID][msg.sender] = true;
        upVoteCount[tokenID] = upVoteCount[tokenID] + 1;
    }

    /**
     * @notice Count msg.sender's downvote for a token
     * @dev Only allows one vote per account per token
     * @param tokenID The ID of the token to downvote
     */
    function downVote(uint256 tokenID)
        public
        noBlacklisters
        onlyNewVoters(tokenID)
        tokenExists(tokenID)
    {
        downVoteAddresses[tokenID][msg.sender] = true;
        downVoteCount[tokenID] = downVoteCount[tokenID] + 1;
    }
}

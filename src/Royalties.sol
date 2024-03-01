// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Royalties is Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdsTracker;
    constructor(string memory _name, string memory _symbol, uint96 _feeNumerator) 
        ERC712(_name, _symbol) 
    {
        _setDefaultRoyalty(msg.sender, _feeNumerator);
    }

    function mintNFT(address recipient, string memory tokenURI) 
        public 
        onlyOwner
        returns (uint256) 
    {
        _tokenIdsTracker.increment();
        uint tokenId = _tokenIdsTracker.current();
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return tokenId;
    }

    function mintNFTWithRoyalty(
        address recipient, 
        string memory tokenURI, 
        address royaltyReceiver, 
        uint96 feeNumerator
    ) 
        public 
        onlyOwner 
        returns (uint256) 
    {
        uint tokenId = mintNFT(recipient, tokenURI);
        _setTokenRoyalty(tokenId, royaltyReceiver, feeNumerator);
        return tokenId;
    }
}

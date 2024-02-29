// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";

contract Royalties {

}    constructor(string memory _name, string memory _symbol, uint96 _feeNumerator) 
        ERC712(_name, _symbol) 
    {
        _setDefaultRoyalty(msg.sender, _feeNumerator);
    }

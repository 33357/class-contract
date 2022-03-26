//SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    event NFTClaimed(address owner, uint256 tokenId);

    Counters.Counter public tokenCount;
    string public baseURI;

    constructor() ERC721("MyNFT", "MyNFT") {}

    /* ================ UTIL FUNCTIONS ================ */

    function _baseURI() internal view override(ERC721) returns (string memory) {
        return baseURI;
    }

    function _awardNFT(address receiver) internal returns (uint256) {
        tokenCount.increment();
        uint256 newId = tokenCount.current();
        _safeMint(receiver, newId);
        return newId;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    /* ================ VIEW FUNCTIONS ================ */

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    /* ================ TRANSACTION FUNCTIONS ================ */

    function getNFT() external {
        uint256 tokenId = _awardNFT(_msgSender());
        emit NFTClaimed(_msgSender(), tokenId);
    }

    /* ================ ADMIN FUNCTIONS ================ */
}

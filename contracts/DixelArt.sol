// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./lib/Base64.sol";
import "./lib/ColorUtils.sol";
import "./DixelSVGGenerator.sol";

/**
 * @dev DixelArt NFT token, including:
 *
 *  - ability for holders to burn (destroy) their tokens
 *  - a owner (Dixel contract) that allows for token minting (creation)
 *  - token ID and URI autogeneration
 */
contract DixelArt is
    Context,
    ERC721Enumerable,
    Ownable,
    DixelSVGGenerator
{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdTracker;

    IERC20 public baseToken;

    struct History {
        uint24[CANVAS_SIZE][CANVAS_SIZE] pixels;
        uint16 updatedPixelCount;
        uint96 reserveForRefund;
    }
    History[] public history;

    constructor(address baseTokenAddress) ERC721("Dixel Collection", "dART") {
        baseToken = IERC20(baseTokenAddress);
    }

    // Approve token spending by this contract, should be called after construction
    function initApprove() external onlyOwner {
        require(baseToken.approve(address(this), 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff), 'APPROVE_FAILED');
    }

    function getPixelsFor(uint256 tokenId) public view returns (uint24[CANVAS_SIZE][CANVAS_SIZE] memory) {
        return history[tokenId].pixels;
    }

    function generateSVG(uint256 tokenId) external view returns (string memory) {
        return _generateSVG(getPixelsFor(tokenId));
    }

    function generateBase64SVG(uint256 tokenId) public view returns (string memory) {
        return _generateBase64SVG(getPixelsFor(tokenId));
    }

    function generateJSON(uint256 tokenId) public view returns (string memory json) {
        // NOTE: We don't check token existence here,
        // so burnt tokens can also outputs this result unlike tokenURI function

        json = string(abi.encodePacked(
            '{"name":"Dixel Collection #',
            ColorUtils.uint2str(tokenId),
            '","description":"A single art canvas where users can overwrite price-compounded pixels to generate fully on-chain NFT via dixel.club',
            '","updated_pixel_count":"',
            ColorUtils.uint2str(history[tokenId].updatedPixelCount),
            '","reserve_for_refund":"',
            ColorUtils.uint2str(history[tokenId].reserveForRefund),
            '","image":"',
            generateBase64SVG(tokenId),
            '"}'
        ));
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return string(abi.encodePacked('data:application/json;base64,', Base64.encode(bytes(generateJSON(tokenId)))));
    }

    function mint(address to, uint24[CANVAS_SIZE][CANVAS_SIZE] memory pixelColors, uint16 updatedPixelCount, uint96 reserveForRefund) public onlyOwner {
        // We cannot just use balanceOf to create the new tokenId because tokens
        // can be burned (destroyed), so we need a separate counter.
        uint256 tokenId = _tokenIdTracker.current();
        _mint(to, tokenId);

        history.push(History(pixelColors, updatedPixelCount, reserveForRefund));

        _tokenIdTracker.increment();
    }

    function burn(uint256 tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Burnable: caller is not owner nor approved");

        _burn(tokenId);

        // Refund reserve amount
        require(baseToken.transfer(_msgSender(), history[tokenId].reserveForRefund), 'REFUND_FAILED');
    }

    // MARK: - External utility functions

    function nextTokenId() external view returns (uint256) {
        return _tokenIdTracker.current();
    }

    function exists(uint256 tokenId) external view returns (bool) {
        return _exists(tokenId);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
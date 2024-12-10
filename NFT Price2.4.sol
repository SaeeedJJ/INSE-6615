// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol"; 
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract MyToken is ERC721, ERC721URIStorage, ERC721Burnable, Ownable, AccessControl, ReentrancyGuard, Pausable {
    uint256 public mintPrice ;
    uint256 public maxSupply;
    uint256 public totalMinted;
    string private baseTokenURI;
    mapping(uint256 => bool) private _tokenExists;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    event Mint(address indexed to, uint256 indexed tokenId, string uri);
    event Withdrawal(address indexed owner, uint256 amount);
    event MintPriceUpdated(uint256 newPrice);
    event MaxSupplyUpdated(uint256 newMaxSupply);

    constructor(
        string memory _baseTokenURI,
        uint256 _maxSupply,
        address initialOwner
    ) ERC721("Cat Art Token", "CAT") Ownable(initialOwner) {
        require(initialOwner != address(0), "Invalid owner address");
        require(bytes(_baseTokenURI).length > 0, "Base URI required");
        require(_maxSupply > 0, "Max supply must be greater than zero");

        baseTokenURI = _baseTokenURI;
        maxSupply = _maxSupply;

        // Grant roles to the initial owner
        _grantRole(DEFAULT_ADMIN_ROLE, initialOwner);
         grantRole(MINTER_ROLE, initialOwner);
         grantRole(PAUSER_ROLE, initialOwner);

    }

    modifier onlyNonZeroAddress(address to) {
        require(to != address(0), "Cannot mint to zero address");
        _;
    }

    function safeMint(address to, uint256 tokenId, string memory uri)
        public
        payable
        nonReentrant
        whenNotPaused
        onlyNonZeroAddress(to)
        onlyRole(MINTER_ROLE)
    {
        require(!_tokenExists[tokenId], "Token ID already exists");
        require(totalMinted < maxSupply, "Max supply reached");
        require(msg.value >= mintPrice, "Insufficient payment");

        _tokenExists[tokenId] = true;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        totalMinted++;

        emit Mint(to, tokenId, uri);
    }

    function setMintPrice(uint256 newPrice) external onlyOwner {
        mintPrice = newPrice;
        emit MintPriceUpdated(newPrice);
    }

    function setMaxSupply(uint256 newMaxSupply) public onlyOwner {
        require(newMaxSupply >= totalMinted, "Cannot reduce max supply below total minted");
        maxSupply = newMaxSupply;
        emit MaxSupplyUpdated(newMaxSupply);
    }

    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        require(bytes(_baseTokenURI).length > 0, "Base URI cannot be empty");
        baseTokenURI = _baseTokenURI;
    }

    function baseURI() public view returns (string memory) {
        return baseTokenURI;
    }

    function withdraw() public onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Transfer failed");
        emit Withdrawal(msg.sender, balance);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function burnToken(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Caller is not token owner");
        _burn(tokenId); // Call the base `_burn` method
    }

    function batchMint(address to, uint256[] memory tokenIds, string[] memory uris) 
        public 
        payable 
        onlyRole(MINTER_ROLE)
    {
        require(tokenIds.length == uris.length, "Token IDs and URIs length mismatch");
        require(totalMinted + tokenIds.length <= maxSupply, "Max supply reached");
        require(msg.value >= mintPrice * tokenIds.length, "Insufficient payment");

        for (uint256 i = 0; i < tokenIds.length; i++) {
            require(!_tokenExists[tokenIds[i]], "Token ID already exists");
            _tokenExists[tokenIds[i]] = true;
            _safeMint(to, tokenIds[i]);
            _setTokenURI(tokenIds[i], uris[i]);
            totalMinted++;
            emit Mint(to, tokenIds[i], uris[i]);
        }
    }
fallback() external payable {
    // Log the details of the transaction
    emit FallbackTriggered(msg.sender, msg.value, msg.data);

    // Optional: Add logic here
}

receive() external payable {
    emit Received(msg.sender, msg.value);
}

event FallbackTriggered(address sender, uint256 value, bytes data);
event Received(address sender, uint256 value);



}

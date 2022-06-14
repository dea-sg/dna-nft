// SPDX-License-Identifier: MPL-2.0
pragma solidity =0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@dea-sg/layerzero/contracts/ERC721/OmniERC721Upgradeable.sol";

contract DNAToken is
	OwnableUpgradeable,
	UUPSUpgradeable,
	OmniERC721Upgradeable
{
	using CountersUpgradeable for CountersUpgradeable.Counter;
	CountersUpgradeable.Counter private _tokenCounter;

	function initialize() public initializer {
		__Ownable_init();
		__UUPSUpgradeable_init();
		// TODO name and symbol
		__ERC721_init("dna", "DNA");
	}

	// free mint
	function mint() external {
		address _to = msg.sender;
		uint256 _newTokenId = _tokenCounter.current();
		_mint(_to, _newTokenId);
		_tokenCounter.increment();
	}

	// TODO https://docs.opensea.io/docs/metadata-standards#metadata-structure
	function tokenURI(uint256 tokenId)
		public
		view
		virtual
		override
		returns (string memory)
	{
		require(_exists(tokenId), "not found");

		// string memory baseURI = _baseURI();
		// return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
		return "";
	}

	function _authorizeUpgrade(address) internal override onlyOwner {}
}

//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
pragma experimental ABIEncoderV2;

import "hardhat/console.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./libraries/BuildSvg.sol";

import { Base64 } from "./libraries/Base64.sol";

contract TheLShips is ERC721URIStorage {
  using Counters for Counters.Counter;
  // Counter starts at 0
  Counters.Counter private _tokenIds;
  
  event NewTokenMinted(address _sender, uint _tokenId, uint _char1Id, uint _char2Id);

  string private _contractURI;
  
  string[] public chars = [
    "Bette", 
    "Tina", 
    "Shane", 
    "Alice", 
    "Dana", 
    "Tasha",
    "Gigi",
    "Dani", 
    "Sophie", 
    "Pippa" ,
    "Micah",
    "Finely",
    "Jennny",
    "Marina",
    "Carmen",
    "Helena", 
    "Jamie",
    "Lover Cindy",
    "Dawn Denbo",
    "Max",
    "Gabby",
    "Paige",
    "Papi",
    "Marina",
    "Cherie Jaffe",
    "Candace",
    "Jodi", 
    "Phyllis",
    "Joyce",
    "Nikki",
    "Lisa",
    "Dylan",
    "Lara",
    "Tonya",
    "Uta"    
  ];

  mapping(uint => uint[]) pairs;
  bytes32[] pairHashes;

  modifier supplyRemaining {
    require(_tokenIds.current() < calcUniquePairCount(), "Max supply reached!");
    _;
  }

  modifier sufficientChars {
    require(chars.length > 1, "Must have at least 2 characters in chars array to initialize!");
    _;
  }

  constructor(string memory _name, string memory _symbol, string memory _description) ERC721(_name, _symbol) sufficientChars {
    _tokenIds.increment(); // start counting at 1

    string memory contractURIEndcoded_ = buildContractURIEncoded(_name, _description);
    setContractURI(contractURIEndcoded_);
  }
  
  function totalSupply() public view returns (uint) {
    // Tokens increments after successful mint, so subtract 1 to get current total.
    return _tokenIds.current() - 1; 
  }

  function getCharsCount() public view returns (uint) {
    return chars.length; 
  }

  /** Calculate number of possible unique pairs using round robin algorithm */
  function calcUniquePairCount() public view returns (uint){
    uint _charCount = chars.length;
    if(_charCount < 2) return 0;
    return _charCount * (_charCount - 1) / 2;
  }

  /** 
    Adds hashes of both combos ("1x2" and "2x1") to pairHashes.
    This allows us to prevent minting duplicate pairs in the future using the isUniquePair function.
  */     
  function addPairHashes(uint _char1Id, uint _char2Id) internal {
    pairHashes.push(keccak256(abi.encodePacked(_char1Id, "x", _char2Id)));
    pairHashes.push(keccak256(abi.encodePacked(_char2Id, "x", _char1Id)));
  }

  function mintShip() public supplyRemaining {
    string memory char1;
    string memory char2;
    uint char1Id;
    uint char2Id;

    uint tokenId = _tokenIds.current();

    (char1Id, char2Id) = getUniqueNewIdPair(tokenId);

    char1 = chars[char1Id];
    char2 = chars[char2Id];

    string memory finalSvg = BuildSvg.buildSvg(char1, char2);

    /** Get all the JSON metadata in place and base64 encode it. */ 
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // Name is char1 x char2
                    char1," x ",char2,
                    '", "description": "Just two fish in the sea", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),
                    '", "attributes": { "char1": "',
                    char1,
                    '", "char2": "',
                    char2,
                    '"} }'
                )
            )
        )
    );

    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    _safeMint(msg.sender, tokenId);

    _setTokenURI(tokenId, finalTokenUri);

    // On successful mint add the pair to pairHashes and increment tokenId
    addPairHashes(char1Id, char2Id);
    _tokenIds.increment();

    console.log("An NFT w/ ID %s has been minted to %s", tokenId, msg.sender);
    emit NewTokenMinted(msg.sender, tokenId, char1Id, char2Id);
  }

  function getRandomChar1Id(uint _tokenId, uint _seed) public view returns (uint) {
    uint rand = random(string(abi.encodePacked(Strings.toString(_seed), Strings.toString(_tokenId))));
    rand = rand % chars.length;
    return rand;
  } 

  /** Get a second random ID exclusive of the first. People can't date themselves. */
  function getRandomChar2Id(uint _tokenId, uint _seed, uint _exclude) public view returns (uint) {
    // Create array of all indexes (charIds) except _exclude
    uint[] memory filteredIndexes = new uint[](chars.length - 1);
    uint j = 0;
    for(uint i; i < chars.length; i++) {
      if(i != _exclude) {
        filteredIndexes[j] = i;
        j++;
      }
    }

    uint rand = random(string(abi.encodePacked(Strings.toString(_seed), Strings.toString(_tokenId))));
    uint randomIndex = rand % filteredIndexes.length;

    return filteredIndexes[randomIndex];
  } 

  function getRandomIdPair(uint _tokenId, uint _seed) internal view returns (uint, uint)  {
    uint char1Id = getRandomChar1Id(_tokenId, _seed);
    uint char2Id = getRandomChar2Id(_tokenId, _seed + 1 , char1Id);
    return (char1Id, char2Id);
  }

  function getUniqueNewIdPair(uint _tokenId) internal view supplyRemaining returns (uint, uint) {
    uint char1Id;
    uint char2Id;
    uint seed = 1;
    // Loop until unique
    while(true) {
      (char1Id, char2Id) = getRandomIdPair(_tokenId, seed);
      seed++;
      bool isUnique = isUniquePair(char1Id, char2Id);
      if(isUnique){
        break;
      }
    } 
    return (char1Id, char2Id);
  }

  // Leave this public in case app wants to check for unique pairs
  function isUniquePair(uint _char1Id, uint _char2Id) public view returns (bool) {
    bytes32 _pairHash = keccak256(abi.encodePacked(_char1Id, "x", _char2Id));
    bool isUnique = true;
    // check to see if pair hash already exists
    for(uint i = 0; i < pairHashes.length; i++) {
      isUnique = !(compareStrings(bToS(pairHashes[i]), bToS(_pairHash)));
      if(!isUnique) {
        break;
      }
    }
    return isUnique;
  }

  function buildContractURIEncoded(string memory _name, string memory _description) private pure returns (string memory){
    return Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    _name,
                    '", "description": "',
                    _description,
                    '", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(BuildSvg.logoSvg())),
                    '"}'
                )
            )
        )
    );
  }

  function setContractURI(string memory contractURIEncoded_) private {
    _contractURI = string(abi.encodePacked(
        "data:application/json;base64,", contractURIEncoded_
  
    ));
  }

  function contractURI() public view returns (string memory) {
    return _contractURI;
  }
 
  function bToS(bytes32 b) internal pure  returns (string memory) {
    return string(abi.encodePacked(b));
  }

  function random(string memory _input) internal pure returns (uint) {
     return uint(keccak256(abi.encodePacked(_input)));
  }

  function compareStrings(string memory a, string memory b) public pure returns (bool) {
    return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
  }
}
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import { Base64 } from "./libraries/Base64.sol";

contract TheLShips is ERC721URIStorage {
  using Counters for Counters.Counter;
  // Counter starts at 0
  Counters.Counter private _tokenIds;
  
  event NewTokenMinted(address _sender, uint256 _tokenId);

  string baseSvg = "<svg viewBox='126.649 81.135 246.702 156.332' xmlns='http://www.w3.org/2000/svg'><defs><linearGradient gradientUnits='userSpaceOnUse' x1='199.209' y1='85.752' x2='199.209' y2='242.084' id='gradient-1' spreadMethod='pad' gradientTransform='matrix(0.302835, 0.953043, -1.354435, 0.430379, 400.145294, -57.2355)'><stop offset='0' style='stop-color: rgba(255, 178, 115, 1)'/><stop offset='1' style='stop-color: rgba(255, 122, 13, 1)'/></linearGradient></defs><g transform='matrix(1, 0, 0, 1, 0.000001, -4.617414)'><rect x='126.649' y='85.752' width='246.702' height='156.332' style='paint-order: fill; fill-rule: nonzero; fill: url(#gradient-1);'/><text style='fill: rgb(255, 255, 255); font-family: Arial, sans-serif; font-size: 21px; font-weight: 700; text-transform: uppercase; white-space: pre;' x='50%' y='150'><tspan x='140' dy='1.2em'>";
  
  string[] public chars = [
    "Bette", 
    "Tina", 
    "Shane", 
    "Alice", 
    "Dana", 
    "Gigi", 
    "Dani", 
    "Sophie", 
    "Pippa", 
    "Jennny",
    "Marina",
    "Carmen",
    "Helena"
    ];

  constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){}

  function mintShip() public {
    string memory char1;
    string memory char2;

    uint tokenId = _tokenIds.current();
    (char1, char2) = getRandomPair(tokenId);

    string memory finalSvg = buildSvg(char1, char2);


    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // Name is char1 x char2
                    char1," x ",char2,
                    '", "description": "Two fish in the sea", "image": "data:image/svg+xml;base64,',
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

    console.log("tokenURI: ", finalTokenUri);

    _safeMint(msg.sender, tokenId);

    _setTokenURI(tokenId, finalTokenUri);

    console.log("An NFT w/ ID %s has been minted to %s", tokenId, msg.sender);

    _tokenIds.increment();

    emit NewTokenMinted(msg.sender, tokenId);
  }

  function getRandomChar(uint _tokenId, uint16 _charNum) public view returns (string memory) {
    uint rand = random(string(abi.encodePacked(Strings.toString(_charNum), Strings.toString(_tokenId))));
    rand = rand % chars.length;
    return chars[rand];
  } 

  function getRandomCharWithout(uint _tokenId, uint16 _charNum, string memory _char) public view returns (string memory) {
    string[] memory filtered = charsWithout(_char);
    uint rand = random(string(abi.encodePacked(Strings.toString(_charNum), Strings.toString(_tokenId))));
    rand = rand % filtered.length;
    return filtered[rand];
  } 

  function getRandomPair(uint _tokenId) internal view returns (string memory, string memory)  {
    string memory char1 = getRandomChar(_tokenId, 1);
    string memory char2 = getRandomCharWithout(_tokenId, 2, char1);

    return (char1, char2);
  }

  function random(string memory _input) internal pure returns (uint) {
     return uint(keccak256(abi.encodePacked(_input)));
  }

  function charsWithout(string memory _char) internal view returns (string[] memory) {
    uint filteredLength = chars.length - 1;
    string[] memory filtered = new string[](filteredLength); 

    uint j = 0;
    for(uint i = 0; i < chars.length; i++) {
      if(!compareStrings(_char, chars[i])) {
        filtered[j] = chars[i];
        j++;
      }
    }
    return filtered;
  }

  function compareStrings(string memory a, string memory b) public pure returns (bool) {
    return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
  }


  function buildSvg(string memory _char1, string memory _char2) public view returns (string memory){
    string memory finalSvg = string(abi.encodePacked(
      baseSvg, 
      _char1, 
      "</tspan><tspan x='140' dy='1.2em'>x</tspan><tspan x='140' dy='1.2em'>",
      _char2,
      "</tspan></text></g></svg>")
    );
    console.log("\n--------------------");
    console.log(finalSvg);
    console.log("--------------------\n");
    return finalSvg;
  }
}
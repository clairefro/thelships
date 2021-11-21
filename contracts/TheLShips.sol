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

  string baseSvg = "<svg viewBox='126.649 81.135 246.702 156.332' xmlns='http://www.w3.org/2000/svg'><defs><linearGradient gradientUnits='userSpaceOnUse' x1='199.209' y1='85.752' x2='199.209' y2='242.084' id='gradient-1' spreadMethod='pad' gradientTransform='matrix(0.302835, 0.953043, -1.354435, 0.430379, 400.145294, -57.2355)'><stop offset='0' style='stop-color: rgba(255, 178, 115, 1)'/><stop offset='1' style='stop-color: rgba(255, 122, 13, 1)'/></linearGradient></defs><g transform='matrix(1, 0, 0, 1, 0.000001, -4.617414)'><rect x='126.649' y='85.752' width='246.702' height='156.332' style='paint-order: fill; fill-rule: nonzero; fill: url(#gradient-1);'/><text style='fill: rgb(255, 255, 255); font-family: Arial, sans-serif; font-size: 21px; font-weight: 700; text-transform: uppercase; white-space: pre;' x='50%' y='150'><tspan x='140' dy='1.2em'>";
  
  string[] chars = [
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

  constructor() ERC721("TheLShips", "LSHIP"){
    console.log("Yo from the constructor");
  }

  function mintShip() public {
    uint tokenId = _tokenIds.current();
    string memory char1 = getRandomChar(tokenId, 1);
    string memory char2 = getRandomChar(tokenId, 2);

    string memory finalSvg = buildSvg(char1, char2);


    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // Name is char1xchar2
                    char1," x ",char2,
                    '", "description": "Two fish in the sea", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),
                    '"}'
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
  }

  function getRandomChar(uint _tokenId, uint16 _charNum) public view returns (string memory) {
    uint rand = random(string(abi.encodePacked(Strings.toString(_charNum), Strings.toString(_tokenId))));
    rand = rand % chars.length;
    return chars[rand];
  } 

  function random(string memory _input) internal pure returns (uint) {
     return uint(keccak256(abi.encodePacked(_input)));
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
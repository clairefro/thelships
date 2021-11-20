//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

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

    _safeMint(msg.sender, tokenId);

    // _setTokenURI(tokenId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiVGhlIE9yaWdpbmFsIEwgU2hpcCIsCiAgICAiZGVzY3JpcHRpb24iOiAiQSBwcm90b3NoaXAiLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEQ5NGJXd2dkbVZ5YzJsdmJqMGlNUzR3SWlCbGJtTnZaR2x1WnowaWRYUm1MVGdpUHo0S1BITjJaeUIyYVdWM1FtOTRQU0l4TWpZdU5qUTVJRGd4TGpFek5TQXlORFl1TnpBeUlERTFOaTR6TXpJaUlIaHRiRzV6UFNKb2RIUndPaTh2ZDNkM0xuY3pMbTl5Wnk4eU1EQXdMM04yWnlJK0NpQWdQR1JsWm5NK0NpQWdJQ0E4YkdsdVpXRnlSM0poWkdsbGJuUWdaM0poWkdsbGJuUlZibWwwY3owaWRYTmxjbE53WVdObFQyNVZjMlVpSUhneFBTSXhPVGt1TWpBNUlpQjVNVDBpT0RVdU56VXlJaUI0TWowaU1UazVMakl3T1NJZ2VUSTlJakkwTWk0d09EUWlJR2xrUFNKbmNtRmthV1Z1ZEMweElpQnpjSEpsWVdSTlpYUm9iMlE5SW5CaFpDSWdaM0poWkdsbGJuUlVjbUZ1YzJadmNtMDlJbTFoZEhKcGVDZ3dMak13TWpnek5Td2dNQzQ1TlRNd05ETXNJQzB4TGpNMU5EUXpOU3dnTUM0ME16QXpOemtzSURRd01DNHhORFV5T1RRc0lDMDFOeTR5TXpVMUtTSStDaUFnSUNBZ0lEeHpkRzl3SUc5bVpuTmxkRDBpTUNJZ2MzUjViR1U5SW5OMGIzQXRZMjlzYjNJNklISm5ZbUVvTWpVMUxDQXhOemdzSURFeE5Td2dNU2tpTHo0S0lDQWdJQ0FnUEhOMGIzQWdiMlptYzJWMFBTSXhJaUJ6ZEhsc1pUMGljM1J2Y0MxamIyeHZjam9nY21kaVlTZ3lOVFVzSURFeU1pd2dNVE1zSURFcElpOCtDaUFnSUNBOEwyeHBibVZoY2tkeVlXUnBaVzUwUGdvZ0lEd3ZaR1ZtY3o0S0lDQThaeUIwY21GdWMyWnZjbTA5SW0xaGRISnBlQ2d4TENBd0xDQXdMQ0F4TENBd0xqQXdNREF3TVN3Z0xUUXVOakUzTkRFMEtTSStDaUFnSUNBOGNtVmpkQ0I0UFNJeE1qWXVOalE1SWlCNVBTSTROUzQzTlRJaUlIZHBaSFJvUFNJeU5EWXVOekF5SWlCb1pXbG5hSFE5SWpFMU5pNHpNeklpSUhOMGVXeGxQU0p3WVdsdWRDMXZjbVJsY2pvZ1ptbHNiRHNnWm1sc2JDMXlkV3hsT2lCdWIyNTZaWEp2T3lCbWFXeHNPaUIxY213b0kyZHlZV1JwWlc1MExURXBPeUl2UGdvZ0lDQWdQSFJsZUhRZ2MzUjViR1U5SW1acGJHdzZJSEpuWWlneU5UVXNJREkxTlN3Z01qVTFLVHNnWm05dWRDMW1ZVzFwYkhrNklFRnlhV0ZzTENCellXNXpMWE5sY21sbU95Qm1iMjUwTFhOcGVtVTZJREl4Y0hnN0lHWnZiblF0ZDJWcFoyaDBPaUEzTURBN0lIUmxlSFF0ZEhKaGJuTm1iM0p0T2lCMWNIQmxjbU5oYzJVN0lIZG9hWFJsTFhOd1lXTmxPaUJ3Y21VN0lpQjRQU0l5TWpVdU5UQTFJaUI1UFNJeE5qZ3VORGs0SWo1VFNFbFFQQzkwWlhoMFBnb2dJRHd2Wno0S1BDOXpkbWMrIgp9");
    _setTokenURI(tokenId, "foo");
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
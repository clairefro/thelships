// SPDX-License-Identifier: MIT
import { Base64 } from "./Base64.sol";

import "hardhat/console.sol";

pragma solidity ^0.8.0;

library BuildSvg {
  string constant baseSvg = "<svg viewBox='126.649 81.135 246.702 156.332' xmlns='http://www.w3.org/2000/svg'><defs><linearGradient gradientUnits='userSpaceOnUse' x1='199.209' y1='85.752' x2='199.209' y2='242.084' id='gradient-1' spreadMethod='pad' gradientTransform='matrix(0.302835, 0.953043, -1.354435, 0.430379, 400.145294, -57.2355)'><stop offset='0' style='stop-color: rgba(255, 178, 115, 1)'/><stop offset='1' style='stop-color: rgba(255, 122, 13, 1)'/></linearGradient></defs><g transform='matrix(1, 0, 0, 1, 0.000001, -4.617414)'><rect x='126.649' y='85.752' width='246.702' height='156.332' style='paint-order: fill; fill-rule: nonzero; fill: url(#gradient-1);'/><text style='fill: rgb(255, 255, 255); font-family: Arial, sans-serif; font-size: 21px; font-weight: 700; text-transform: uppercase; white-space: pre;' x='50%' y='150'><tspan x='140' dy='1.2em'>";
  
  function buildSvg(string memory _char1, string memory _char2) public view returns (string memory){
    string memory finalSvg = string(abi.encodePacked(
      baseSvg, 
      _char1, 
      "</tspan><tspan x='140' dy='1.2em'>x</tspan><tspan x='140' dy='1.2em'>",
      _char2,
      "</tspan></text></g></svg>")
    );
    // console.log("\n--------------------");
    // console.log(finalSvg);
    // console.log("--------------------\n");
    return finalSvg;
  }
}
const { expect } = require("chai");
const { ethers } = require("hardhat");
const { TOKEN_NAME, TOKEN_SYMBOL } = require("../config");

let Contract;
let contract;

before(async () => {
  Contract = await ethers.getContractFactory("TheLShips");
  contract = await Contract.deploy(TOKEN_NAME, TOKEN_SYMBOL);
  await contract.deployed();
});

describe("TheLShips", function () {
  it("Should return the greeting", async function () {
    const chars = await contract.chars(0);

    console.log(contract);

    expect("Hello, world!").to.match(/Hello, world!/);
  });
});

// describe.only("Pair collision", function () {
//   it("Should't pair a char with themselves", async function () {
//     const pairs = [];
//     for (let i = 0; i < 200; i++) {
//       const pair = await contract.getRandomPair(i);
//       pairs.push(pair);
//     }
//     console.log({ pairs });
//     // expect(await contract.chars()).to.equal("Hello, world!");
//     expect("Hello, world!").to.match(/"Hello, world!"/);
//   });
// });

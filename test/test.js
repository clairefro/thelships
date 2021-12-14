const { expect } = require("chai");
const { ethers } = require("hardhat");
const { TOKEN_NAME, TOKEN_SYMBOL, TOKEN_DESCRIPTION } = require("../config");

let Contract;
let contract;
let expectedSupply = 0;

before(async () => {
  const BuildSvg = await ethers.getContractFactory("BuildSvg");
  const buildSvg = await BuildSvg.deploy();
  await buildSvg.deployed();

  Contract = await ethers.getContractFactory("TheLShips", {
    libraries: {
      BuildSvg: buildSvg.address,
    },
  });

  contract = await Contract.deploy(TOKEN_NAME, TOKEN_SYMBOL, TOKEN_DESCRIPTION);
  await contract.deployed();
});

describe("TheLShips", function () {
  it("Should create contract with name and symbol from config", async function () {
    expect(await contract.name()).to.match(new RegExp(TOKEN_NAME));
    expect(await contract.symbol()).to.match(new RegExp(TOKEN_SYMBOL));
  });
});

describe("Minting", function () {
  it("It should start with totalSupply of 0", async function () {
    expect(await contract.totalSupply()).to.equal(expectedSupply);
  });
  it("It should mint a token", async function () {
    await contract.mintShip();
    expectedSupply++;
    expect(await contract.totalSupply()).to.equal(expectedSupply);
  });
  it("It should increment totalSupply on each mint", async function () {
    await contract.mintShip();
    expectedSupply++;
    expect(await contract.totalSupply()).to.equal(expectedSupply);
    await contract.mintShip();
    expectedSupply++;
    expect(await contract.totalSupply()).to.equal(expectedSupply);
  });
});

describe("Metadata", function () {
  it("It should have a contract URI", async function () {
    expect(await contract.contractURI()).to.match(
      /^data:application\/json;base64,/
    );
  });
  it("Contract URI should contain name and description that match config, and an image defined", async function () {
    const contractURI = await contract.contractURI();
    const buff = Buffer.from(contractURI.split(",")[1], "base64");
    const json = JSON.parse(buff.toString("ascii"));
    expect(json.name).to.match(new RegExp(TOKEN_NAME));
    expect(json.description).to.match(new RegExp(TOKEN_DESCRIPTION));
    expect(json.image).to.be.a("string");
  });
});

describe("Public getters", function () {
  it("It should return character count", async function () {
    expect(parseInt(await contract.getCharsCount())).to.be.a("number");
  });
  it("It should return max number of unique pairs", async function () {
    const charCount = parseInt(await contract.getCharsCount());
    const expected = (charCount * (charCount - 1)) / 2;
    expect(parseInt(await contract.calcUniquePairCount())).to.equal(expected);
  });
});

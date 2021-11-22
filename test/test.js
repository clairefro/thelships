const { expect } = require("chai");
const { ethers } = require("hardhat");
const { TOKEN_NAME, TOKEN_SYMBOL } = require("../config");

let Contract;
let contract;

before(async () => {
  const BuildSvg = await ethers.getContractFactory("BuildSvg");
  const buildSvg = await BuildSvg.deploy();
  await buildSvg.deployed();
  // link(BuildSvg, "contracts/libraries/BuildSvg.sol:BuildSvg", buildSvg.address);

  Contract = await ethers.getContractFactory("TheLShips", {
    libraries: {
      BuildSvg: buildSvg.address,
    },
  });

  contract = await Contract.deploy(TOKEN_NAME, TOKEN_SYMBOL);
  await contract.deployed();
});

describe("TheLShips", function () {
  it("Should create contract with name and symbol from config", async function () {
    expect(await contract.name()).to.match(new RegExp(TOKEN_NAME));
    expect(await contract.symbol()).to.match(new RegExp(TOKEN_SYMBOL));
  });
});

describe("Minting", function () {
  it("Mint a token", async function () {
    const txn = await contract.mintShip();
    // console.log(txn);
    const tokenCnt = await contract.totalSupply();

    expect(tokenCnt).to.equal(2);
  });
});

// describe("Utils", function () {
//   describe("calcUniquePairCount", function () {
//     it("Should calculate round robin pairs acurately", async function () {
//       expect(await contract.calcUniquePairCount(0)).to.equal(0);
//       expect(await contract.calcUniquePairCount(1)).to.equal(0);
//       expect(await contract.calcUniquePairCount(2)).to.equal(1);
//       expect(await contract.calcUniquePairCount(4)).to.equal(6);
//       expect(await contract.calcUniquePairCount(6)).to.equal(15);
//     });
//   });
// });

// NOTE: Must make called functions public temporarily to test
// describe.only("Pair collision", function () {
// it("Should't pair a char with themselves", async function () {
//   const pairs = [];
//   for (let i = 0; i < 50; i++) {
//     const pair = await contract.getRandomIdPair(i);
//     pairs.push(pair);
//   }
//   const noDups = pairs.every((p) => p[0] !== p[1]);
//   expect(noDups).to.equal(true);
// });

// it("Should't duplicate pairs, in any order", async function () {
//   const pairs = [];
//   for (let i = 0; i < 78; i++) {
//     const pair = await contract.getUniqueNewIdPair(i);
//     pairs.push(pair.toString());
//   }
//   const tuples = pairs.map((p) => p.split(","));
//   const noDups = tuples.every((t, i) => {
//     for (let k = 0; k < tuples.length; k++) {
//       if (k == i) {
//         // skip check on current pair
//         return true;
//       }
//       if (
//         (t[0] === tuples[k][0] && t[1] === tuples[k][1]) ||
//         (t[1] === tuples[k][0] && t[0] === tuples[k][1])
//       ) {
//         console.log({ t });
//         console.log({ index: k });
//         console.log({ matched: tuples[k] });
//         return false;
//       } else {
//         return true;
//       }
//     }
//   });
//   // console.log({ pairs: pairs.map((p) => parseInt(p, 16)) });
//   expect(noDups).to.equal(true);
// });

// it("Should't duplicate pairs, in any order", async function () {
//   const pairs = [];
//   for (let i = 0; i < 78; i++) {
//     await contract.mintShip();
//   }

//   // console.log({ pairs: pairs.map((p) => parseInt(p, 16)) });
//   expect(await contract.totalSupply()).to.equal(78);
// });
// });

const { TOKEN_NAME, TOKEN_SYMBOL, TOKEN_DESCRIPTION } = require("../config");

const main = async () => {
  const BuildSvg = await hre.ethers.getContractFactory("BuildSvg");
  const buildSvg = await BuildSvg.deploy();
  await buildSvg.deployed();

  const Contract = await hre.ethers.getContractFactory("TheLShips", {
    libraries: {
      BuildSvg: buildSvg.address,
    },
  });

  contract = await Contract.deploy(TOKEN_NAME, TOKEN_SYMBOL, TOKEN_DESCRIPTION);
  await contract.deployed();

  // const Contract = await hre.ethers.getContractFactory("TheLShips");
  // // deploy (defaults to local ethereum blockchain if no --network arg provided)
  // const contract = await Contract.deploy(TOKEN_NAME, TOKEN_SYMBOL);

  console.log("Deployed to address: ", contract.address);
  // mint nft
  let txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
  txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
  txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
  txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
  txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
  txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
  txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
  txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

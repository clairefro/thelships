const { TOKEN_NAME, TOKEN_SYMBOL } = require("../config");

const main = async () => {
  // const [deployer] = await ethers.getSigners();
  // console.log("Deploying contracts with the account:", deployer.address);
  // console.log("Account balance:", (await deployer.getBalance()).toString());
  // compile
  const Contract = await hre.ethers.getContractFactory("TheLShips");
  // deploy (defaults to local ethereum blockchain if no --network arg provided)
  const contract = await Contract.deploy(TOKEN_NAME, TOKEN_SYMBOL);
  // wait to deploy transaction to complete
  await contract.deployed();
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
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

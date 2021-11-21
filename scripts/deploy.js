const { TOKEN_NAME, TOKEN_SYMBOL } = require("../config");

const main = async () => {
  const Contract = await hre.ethers.getContractFactory("TheLShips");
  // deploy (defaults to local ethereum blockchain if no --network arg provided)
  const contract = await Contract.deploy(TOKEN_NAME, TOKEN_SYMBOL);
  // wait to deploy transaction to complete
  await contract.deployed();
  console.log("Deployed to address: ", contract.address);

  let txn = await contract.mintShip();
  await txn.wait();
  console.log("minted");
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

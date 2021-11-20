const main = async () => {
  const Contract = await hre.ethers.getContractFactory("TheLShips");
  // deploy (defaults to local ethereum blockchain if no --network arg provided)
  const contract = await Contract.deploy();
  // wait to deploy transaction to complete
  await contract.deployed();
  console.log("Deployed to address: ", contract.address);
};

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

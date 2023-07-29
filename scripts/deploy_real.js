const main = async () => {
    const QuerryFactory = await hre.ethers.getContractFactory("Querry");
    const Querry = await QuerryFactory.deploy("0x9264D07a0EB63521e5AB0286f77cf8BD7338f1Fe");
    await Querry.deployed();
  
    console.log("Querry address: ", Querry.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  };
  
  runMain();
const main = async () => {
  const QuestFactory = await hre.ethers.getContractFactory("Quest");
  const Quest = await QuestFactory.deploy();
  await Quest.deployed();

  console.log("Quest address: ", Quest.address);
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
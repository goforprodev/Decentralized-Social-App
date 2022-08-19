const main = async () => {
  // HRE -> Hardhat runtime environment
  const [owner, randomAccount] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  // const waveContract = await waveContractFactory.deploy();
  // deploying our contract and funding it come eth
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("1"),
  });
  await waveContract.deployed();
  console.log("Contract deployed by: " + owner.address);
  console.log("Contract deployed random: " + randomAccount.address);
  console.log("Contract deployed to: " + waveContract.address);

  // get contract balance
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract balance: " + hre.ethers.utils.formatEther(contractBalance)
  );

  let waveCounts;
  waveCounts = await waveContract.getTotalWaves();

  let waveTxn = await waveContract.wave("Hello there from #1");
  await waveTxn.wait();

  let waveTxn2 = await waveContract.wave("Hello there from #2");
  await waveTxn2.wait();
  // get contract balance again to see what happened
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract balance: " + hre.ethers.utils.formatEther(contractBalance)
  );

  waveTxn = await waveContract
    .connect(randomAccount)
    .wave("This is from a random account #3");
  await waveTxn.wait();
  //   check wave count again after wave
  waveCounts = await waveContract.getTotalWaves();

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();

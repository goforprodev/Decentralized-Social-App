const main = async () => {
  // HRE -> Hardhat runtime environment
  const [owner, randomAccount] = await hre.ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy();
  await waveContract.deployed();
  console.log("Contract deployed to: " + waveContract.address);
  console.log(`Contract deployed by: ${owner.address}`);

  let waveCounts;
  waveCounts = await waveContract.getTotalWaves();

  let waveTxn = await waveContract.wave();
  await waveTxn.wait();

  //   check wave count again after wave
  waveCounts = await waveContract.getTotalWaves();

  let wavers = await waveContract.wavers;
  console.log(wavers);
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

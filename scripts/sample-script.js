
const hre = require("hardhat");

async function main() {
  const AAVE = await hre.ethers.getContractFactory("AavePosition");
  const aave = await AAVE.deploy();

  await aave.deployed();

  console.log("AAVE deployed to:", aave.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

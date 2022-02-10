
const hre = require("hardhat");

async function main() {
  const AAVE = await hre.ethers.getContractFactory("AavePosition");
  const aave = await AAVE.deploy();

  await aave.deployed();

  console.log("AAVE deployed to:", aave.address);
  const user = '0x15C6b352c1F767Fa2d79625a40Ca4087Fab9a198';
    var tokenAddresses = ['0x001b3b4d0f3714ca98ba10f6042daebf0b1b7b6f'];
    
    var result = await aave.getAaveV2Position(user.toLocaleLowerCase(), tokenAddresses);
    console.log(result);
};
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

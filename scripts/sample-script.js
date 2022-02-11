
const hre = require("hardhat");

async function main() {
  const AAVE = await hre.ethers.getContractFactory("AavePosition");
  const aave = await AAVE.deploy();

  await aave.deployed();

  console.log("AAVE deployed to:", aave.address);
  const user = '0x15C6b352c1F767Fa2d79625a40Ca4087Fab9a198';
    var tokenAddresses = [
      '0x001B3B4d0F3714Ca98ba10F6042DaEbF0B1B7b6F',
      '0x2058A9D7613eEE744279e3856Ef0eAda5FCbaA7e',
      '0xBD21A10F619BE90d6066c941b04e340841F1F989',
      '0x0d787a4a1548f673ed375445535a6c7A1EE56180',
      '0x3C68CE8504087f89c640D02d133646d98e64ddd9',
      '0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889',
      '0x341d1f30e77D3FBfbD43D17183E2acb9dF25574E'
    ];
    
    var result = await aave.getAaveV2Position(user.toLowerCase(), tokenAddresses);
    console.log(result);
};
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

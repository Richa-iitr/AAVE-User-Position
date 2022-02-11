require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
// const {API_URL,PRIVATE_KEY} = process.env;

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});
module.exports = {
  defaultNetwork: "matic",
  networks: {
    hardhat: {
    },
    matic: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/6OXarysKYq0scJx1uP8RPXxW43Q_eMRj",
      accounts: ["0x4bf8b687733a18539cc8ed0cb0b59853fd11f1730899f14e9c03dad05098994e"],
      gas: 2100000,
      gasPrice: 8000000000,
    }
  },
  solidity: {
    compilers: [
      {
        version: "0.8.4",
      },
      {
        version: "0.8.11",
        settings: {},
      },
    ],
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  }
};

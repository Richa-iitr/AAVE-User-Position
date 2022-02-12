require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
// require('dotenv').config();
// const { API_URL, PRIVATE_KEY,KEY } = process.env;

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

const { API_URL, PRIVATE_KEY } = process.env;

module.exports = {
  // defaultNetwork: "matic",
  networks: {
    hardhat: {
      forking: {
        url: `https://eth-mainnet.alchemyapi.io/v2/${KEY}`,
        blockNumber: 11095000
      }
    },
    matic: {

      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
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
        version: "0.6.12",
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

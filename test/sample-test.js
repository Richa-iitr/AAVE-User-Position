const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should return", async function () {
    const [owner] = await ethers.getSigners();
    const AAVE = await ethers.getContractFactory("AavePosition");
    const aave = await AAVE.deploy();
    const user = '0x15C6b352c1F767Fa2d79625a40Ca4087Fab9a198';
    var addresses = ['0x001b3b4d0f3714ca98ba10f6042daebf0b1b7b6f'];
  
    await aave.getAaveV2Position(user, addresses);
  });
});

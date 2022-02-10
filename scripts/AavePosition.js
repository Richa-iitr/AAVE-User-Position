async function main() {
    const ADDRESS = '0xAf55b422F9FbE80C78F824DbBcA71614d549D163';
    const AAVE = await ethers.getContractFactory('AavePosition');
    const aave = await AAVE.attach(ADDRESS);
    const user = '0x15C6b352c1F767Fa2d79625a40Ca4087Fab9a198';
    var tokenAddresses = ['0x001b3b4d0f3714ca98ba10f6042daebf0b1b7b6f'];
    
    await aave.methods.getAaveV2Position(user, tokenAddresses).call().then((result) => {
        console.log(result);
    });
}
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  }).catch(err => console.log(err));
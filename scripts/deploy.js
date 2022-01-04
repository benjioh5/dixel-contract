// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const accounts = await hre.ethers.getSigners();
  const deployer = accounts[0].address;
  console.log(`Deploy from account: ${deployer}`);

  // MARK: - Deploy test token (only for testnet)
  const testToken = await hre.ethers.getContractFactory('ERC20PresetMinterPauser');
  const token = await testToken.deploy('Test Dixel', 'TEST_DIXEL');
  await token.deployed();
  await token.mint(deployer, '10000000000000000000000'); // 10,000 tokens
  await token.mint('0x91Ec1d18ed7a3587B87066F0Ab1a641dCBb84e9E', '10000000000000000000000'); // tester 1
  await token.mint('0xF6B02237E1EEe17EdC0c0733182929999e5B2b79', '10000000000000000000000'); // tester 2

  console.log(`Test token is deployed at ${token.address}`);

  // MARK: - Deploy NFT contract
  const DixelArt = await hre.ethers.getContractFactory('DixelArt');
  const nft = await DixelArt.deploy();
  await nft.deployed();

  // MARK: - Deploy contract
  const Dixel = await hre.ethers.getContractFactory('Dixel');
  const dixel = await Dixel.deploy(token.address, nft.address);
  await dixel.deployed();

  await nft.transferOwnership(dixel.address);

  console.log('---');
  console.log(`- Test token: ${token.address}`);
  console.log(`- DixelArt NFT: ${nft.address}`);
  console.log(`- Dixel contract: ${dixel.address}`);
};

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

// npx hardhat compile && HARDHAT_NETWORK=bsctest node scripts/deploy.js
// DixelArt
// npx hardhat verify --network bsctest 0x1b706307606Fe17CB23fae555a325F53C4ACC896
// Dixel, BaseToken, DixelArt
// npx hardhat verify --network bsctest 0x767a596F582D274e88a82866705e5957077ACa54 '0x6B04cD496b958C49b1A3Dc1bc8bA08472Fd244DC' '0x1b706307606Fe17CB23fae555a325F53C4ACC896'


const hre = require("hardhat");

async function main(){
  
  const deployedContract = await hre.ethers.deployContract("Site");
await deployedContract.waitForDeployment();
console.log("Site Contract Address:", deployedContract.target);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({path : './.env'});


/** @type import('hardhat/config').HardhatUserConfig */
const private_key = process.env.PRIVATE_KEY;
module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {},
    zkevm: {
      url: process.env.RPC_URL,
      accounts: [private_key],
      },
    },
    paths: {
      artifacts : "./client/src/artifacts",
    },
};

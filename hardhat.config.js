require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    mumbai: {
      // This value will be replaced on runtime
      url: "https://polygon-mumbai.g.alchemy.com/v2/EfYkpdQH2zsdf2gtiVzKdiCkz0oK7OKi",
      accounts: ["726e77ec4bcf97cf316b71c82850c8fc31db4298f96eb334f2580a40d55aafdd"]
    }
    // mainnet: {
    //   url: process.env.PROD_QUICKNODE_KEY,
    //   accounts: [process.env.PRIVATE_KEY],
    // },
  },
};

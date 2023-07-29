const Web3 = require('web3');
const HDWalletProvider = require('@truffle/hdwallet-provider');
const contractABI = require('./contractABI.json');

const privateKey = 'https://polygon-mumbai.g.alchemy.com/v2/EfYkpdQH2zsdf2gtiVzKdiCkz0oK7OKi';
const contractAddress = 'CONTRACT_ADDRESS_HERE';

const provider = new HDWalletProvider({
  privateKeys: ["726e77ec4bcf97cf316b71c82850c8fc31db4298f96eb334f2580a40d55aafdd"],
  providerOrUrl: 'https://polygon-mumbai.g.alchemy.com/v2/EfYkpdQH2zsdf2gtiVzKdiCkz0oK7OKi',
});

const web3 = new Web3(provider);
const contract = new web3.eth.Contract(contractABI, contractAddress);

// Call a function on the contract
contract.methods.functionName(parameters)
  .send({ from: provider.getAddress(), gas: 200000 })
  .then((receipt) => {
    console.log('Transaction receipt:', receipt);
  })
  .catch((error) => {
    console.error('Error:', error);
  });

// Read a value from the contract
contract.methods.variableName().call()
  .then((result) => {
    console.log('Value:', result);
  })
  .catch((error) => {
    console.error('Error:', error);
  });

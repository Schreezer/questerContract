import abi from "./pool.json"
import { ethers } from "ethers";
const main = async () => {
    const contractAddress = "0x79C611fE3E55A31a94879E0887D62cBCaf2a0CF9";
    const contractABI = abi.abi;
    const wave = async () => {
        try {
          const { ethereum } = window;
    
          if (ethereum) {
            console.log("mesa here");
            const provider = new ethers.providers.Web3Provider(ethereum);
            const signer = provider.getSigner();
            const wavePortalContract = new ethers.Contract(contractAddress, contractABI, signer);
            const waveTxn = await wavePortalContract.quest(Bounty, Question, { gasLimit: 300000 });
            
            
            
            console.log("Mining...", waveTxn.hash);
            await waveTxn.wait();
            console.log("Mined -- ", waveTxn.hash);
            alert("Transaction complete");
          } else {
            alert("Could Not Connect to Wallet");
          
            console.log("Ethereum object doesn't exist!");
          }
        } catch (error) {
          alert("Get MetaMask!");
          console.log(error);
        }
      }
  };
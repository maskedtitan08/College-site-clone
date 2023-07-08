import './App.css';
import { useState,useEffect } from "react";
import Student from "./components/Student"
import Results from "./components/Results"
import MarksGrades from "./components/MarksGrades"
import Site from "./artifacts/contracts/Site.sol/Site.json"
import {ethers} from "ethers";
// require("dotenv").config({path:'./.env'});


function App() {
  const[state,setState] = useState({contract: null});
  const[isConnected,setisConneccted] = useState(false);
  const init = async() => {
    let provider;
    if(window.ethereum==null){
      alert("metamask is not installed")
       provider = ethers.getDefaultProvider();
    }
    else{
      provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contractAddress = "0x3B5d3E1Fcf099065f32027d84AD45761cEcf36BF";
      // const contractAddress = process.env.CONTRACT_ADDRESS;

      const contract = new ethers.Contract(contractAddress,Site.abi,signer);
      setState({contract : contract});
      setisConneccted(true);
      console.log(contract);
      }
  }
  return (
    <div className="App">
      <button className="connectButton" onClick={init} disabled = {isConnected}>{isConnected ? "Connected" : "Connect"}</button>
      
       <Student state={state}/> 
      <Results></Results> 
      <MarksGrades />
    </div>
  );
}

export default App;

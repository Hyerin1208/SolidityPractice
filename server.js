const { default: Web3 } = require("web3");

/* 가나시 연결을 해야한다.*/
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
// node.js가 아니고 javascript연결시 이렇게 사용.
const ABI = JSON.parse(
  `[{"inputs":[{"internalType":"string[]","name":"_candidateNames","type":"string[]"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"candidateList","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_name","type":"string"}],"name":"totalVotesFor","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_name","type":"string"}],"name":"validCandidate","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_candidate","type":"string"}],"name":"vodeForCandiodate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"","type":"string"}],"name":"voteReceived","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]`
);
const deployAddress = `0xB9D1F4088ee6Cef6046D92E4000CD117143177e5`;

let candidates = {
  hyerin1: "candidate1",
  hyerin2: "candidate2",
  hyerin3: "candidate3",
};
let VotingContract = new web3.eth.Contract(ABI, deployAddress);

window.addEventListener("DOMContentLoaded", init);
async function init() {
  let candidateNames = Object.keys(candidates);
  for (let i = 0; i < candidateNames.length; i++) {
    let name = candidateNames[i]; // hyerin1
    candidates[name]; // hyerin1
    const nameElement = document.querySelector(`#${candidates[name]}`);
    nameElement.innerHTML = name;

    const countElement = document.querySelector(`#candidateCount${i + 1}`);
    countElement.innerHTMLl = await VotingContract.methods
      .totalVotesFor(`hyerin${i + 1}`)
      .call();
  }
  // console.log('hello world');
  // await VotingContract.methods.voteForCandidate('hyerin1').send({from: '0xB9D1F4088ee6Cef6046D92E4000CD117143177e5'});
  // VotingContract.methods.totalVotesFor('hyerin1').call().then(data=>{
  //     console.log(data);
  // })
}

const btn = document.querySelector("#btn");
btn.addEventListener("click", btnEvent);

async function btnEvent() {
  let candidateName = document.querySelector(`#candidateName`).value;
  await VotingContract.methods
    .voteForCandidate(candidateName)
    .send({ from: "0xC24E788fe21eBa66058B572c9B874400532526B2" });
}

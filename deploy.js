const Web3 = require("web3");
const fs = require("fs");
const { initParams } = require("request");
const { Account } = require("ethereumjs-util");
const IsConstructor = require("es-abstract/2015/IsConstructor");

const ABI = JSON.parse(
  fs.readFileSync("./contracts_Voting_test_sol_Votingtest.abi").toString()
);
const BYTECODE = fs
  .readFileSync("./contracts_Voting_test_sol_Votingtest.bin")
  .toString();

// console.log(ABI);
// console.log(BYTECODE);

// web3와 연결
const accounts = [];
const web3 = new Web3(Web3.givenProvider || "http://localhost:7545");
async function init() {
  // 계정 연결 확인
  await web3.eth.getAccounts().then((data) => {
    // console.log(data);
    data.forEach((x) => {
      accounts.push(x);
    });
  });
}

init().then(() => {
  console.log(accounts);

  // 스마트 컨트랙트 전달
  const votingContract = new web3.eth.Contract(ABI); //,'/* 스마트 컨트랙트 배포 후 주소*/')

  // 컴파일 한거 컨트랙트에 배포
  votingContract
    .deploy({
      data: BYTECODE,
    })
    .send({
      from: accounts[1],
      gas: 1500000,
      gasPrice: "30000000000000",
    })
    .then((newContractsInstance) => {
      console.log(newContractsInstance.options.address);

      //   constructor() {
      //       candidatesVotedCount['Kim'] = 5;
      //   }
      newContractsInstance.methods
        .getVotedCount("HR.Kim")
        .call()
        .then((data) => {
          console.log("Voted Count : " + data);
        });
    });
});

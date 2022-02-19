const Web3 = require("web3");
const fs = require("fs");

const ABI = JSON.parse(
  fs.readFileSync("./contracts_Voting_sol_Voting.abi").toString()
);
const BYTECODE = fs
  .readFileSync("./contracts_Voting_sol_Voting.bin")
  .toString();

const web3 = new Web3(Web3.givenProvider || "http://localhost:7545");
// 블록을 생성할 때 컴파일한 abi의 내용을 컴파일에 넣는다.
const deployContract = new web3.eth.Contract(ABI);
// deploy안에 있는 값은 byte값을 넣어줌. >그래서 arguments

deployContract
  .deploy({
    // 배포를 할때 컴파일한 byte값을 넣음
    data: BYTECODE,
    arguments: [
      ["hyerin1", "hyerin2", "hyerin3"].map((name) =>
        web3.utils.asciiToHex(name)
      ),
    ],
    // 원래 string 값을 못씀 16진수로 바꾸어야 함.
    // {}가 없으면  return 값을 생략해 줄 수 있음.
  }) // 배포를 할 때 생성자를 넣어주는 것. sol안에 생성자를 넣어주는 것이 아님.
  .send({
    // 어느 주소에서 transaction을 발생시킬지 => ganache의 주소 하나를 사용.
    from: "0xB9D1F4088ee6Cef6046D92E4000CD117143177e5",
    gas: 6721975,
  }) //결과값이 프로미스로 떨어져서 then으로 받음.
  .then((newContract) => {
    console.log(newContract.options.address);
  });
// 원래 이런 작업들이 truffle 프레임워크를 이용해서 할 수 있다.
//
/*
  ['ingoo1','ingoo2','ingoo3'].map(name=>{
    return web3.utils.asciiToHex(name);
  })
  */

// 해당 블록 주소에 접속해야함. 내 contract는 그 주소에 있으므로
const contract = new web3.eth.Contract(
  ABI,
  "0xb228839E84053d85c889D38c9F91291115C67dfc"
);

contract.methods
  .totalVotesFor("hyerin1")
  .call()
  .then((data) => {
    console.log(data);
  }); // call을 써야 promise객체로 실행.

contract.methods
  .voteForCandidate("hyerin1")
  .send({ from: "0xb1d928b0FCe7df427259D28f09500a30Bdd4D4b0" });
// 투표하는 메소드에 넣는 from값은 처음 생성한 계정의 주소값을 넣어주면 됨.
// 투표하는 사람. 10개의 계정중에 아무거나 넣어도 상관없음.

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract VotingTest {
    mapping (string => uint) public candidatesVotedCount;

    constructor () {
        candidatesVotedCount['HR.Kim'] = 5;
    }
    // 외부에서 확인가능
    function getVotedCount(string memory _name) external view returns(uint) {
        return candidatesVotedCount[_name];
    }
}
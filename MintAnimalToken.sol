// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MintAnimalToken is ERC721Enumerable {
                     //     name ,    symbol
    constructor() ERC721("h662Animals", "HAS") {}

    mapping(uint256 => uint256) public animalTypes;

    function mintAnimalToken() public {
        // nft가 가진 유일한 값 = totalSupply *ERC721에서 제공하는 것
        uint256 animalTokenId = totalSupply() + 1; // 지금까지 발행된 nft 양을 나타냄.

        // keccak256 알고리즘 : 사용시 byte 코드값을 안에 넣어야 그래서  abi.encodePacked() >> "솔리디티에서 랜덤을 뽑는 방식"
        uint256 animalType = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, animalTokenId))) % 5 + 1;
        
        animalTypes[animalTokenId] = animalType;

        // (minting 누른사람이 주인, tokenid(증명해줄id))
        _mint(msg.sender, animalTokenId); // _mint 도 ERC721 제공기능
    }
}
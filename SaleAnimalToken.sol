// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./MintAnimalToken.sol";

contract SaleAnimalToken {
    MintAnimalToken public mintAnimalTokenAddress; // 주소값 생성

    constructor(address _mintAnimalTokenAddress) { // deploy 할때 위 조소값이 쓰이게 됨.
        mintAnimalTokenAddress = MintAnimalToken(_mintAnimalTokenAddress);
    }
    // _animalTokenId => _price
    mapping(uint256 => uint256) public animalTokenPrices; // 가격 관리 mapping

    // 프론트엔드에서 어떤게 판매되는 NFT인지 확인가능한 배열
    uint256[] public onSaleAnimalTokenArray;

    // 판매 등록 함수                       무엇을 얼마나 팔지 파라미터에 2개
    function setForSaleAnimalToken(uint256 _animalTokenId, uint256 _price) public {
        // 해당 주인이 판매등록을 해야하므로 아래 주소 적고  ownerOf (주인이 누구인지)
        address animalTokenOwner = mintAnimalTokenAddress.ownerOf(_animalTokenId);

        // 함수실행자가 토큰owner가 맞는지
        require(animalTokenOwner == msg.sender, "Caller is not animal token owner");
        // 가격이 0보다 큰지 
        require(_price > 0, "price is zero or lower");
        // 위 mapping을 사용해 아래조건 / 값이 있거나 0이거나 0원이면 이미 팔린것이니까,
        require(animalTokenPrices[_animalTokenId] == 0, "This animal token is already on sale.");
        // 주인, address(this) <SaleAnimalToken의 주소 입력 ..  주인이 판매 권한을 넘겼는지 (ERC721 => isApprovedForAll 기능 내장)
        require(mintAnimalTokenAddress.isApprovedForAll(animalTokenOwner, address(this)), "Animal token did not approve token");

        // mapping 그대로  _animalTokenId 에 값입력
        animalTokenPrices[_animalTokenId] = _price;
        // 판매중인 것은 위 배열에 push
        onSaleAnimalTokenArray.push(_animalTokenId);
    }

    // 구매 함수
    function purchaseAnimalToken(uint256 _animalTokenId) public payable {
        uint256 price = animalTokenPrices[_animalTokenId];
        address animalTokenOwner = mintAnimalTokenAddress.ownerOf(_animalTokenId);

        require(price > 0, "Animal token not sale");
        require(price <= msg.value, "Caller sent lower than price");
        // 주인이 아니여야 구매 가능
        require(animalTokenOwner != msg.sender, "Caller is animal token owner.");

        // 가격만큼 token이 주인한테 전송
        payable(animalTokenOwner).transfer(msg.value);
        // nft는 돈을 지불한 사람에게 전송
        mintAnimalTokenAddress.safeTransferFrom(animalTokenOwner, msg.sender, _animalTokenId);

        // 판매중인 목록에서 빼는것 (가격을 0원으로 초기화)
        animalTokenPrices[_animalTokenId] = 0;

        for(uint256 i = 0; i < onSaleAnimalTokenArray.length; i++) {
            if(animalTokenPrices[onSaleAnimalTokenArray[i]] == 0) {
                onSaleAnimalTokenArray[i] = onSaleAnimalTokenArray[onSaleAnimalTokenArray.length - 1];
                onSaleAnimalTokenArray.pop();
            }
        }

    }

    // 프론트앤드를 위한 판매중인 토큰 길이 출력함수
    function getOnSaleAnimalTokenArrayLength() view public returns (uint256) {
        return onSaleAnimalTokenArray.length; //판매중인 nft 리스트 가져오는 것.
    }
}
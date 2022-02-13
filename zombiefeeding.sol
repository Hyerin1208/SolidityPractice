pragma solidity ^0.4.19;

// import로 위 Zombiefactory.sol을 불러오기
import "./zombiefactory.sol";

// KittyInterface라는 인터페이스를 정의 + getKitty()함수를 인터페이스 내에 선언
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

// ZombieFeeding이 ZombieFactory를 상속함.
contract ZombieFeeding is ZombieFactory {

    // CryptoKitties 컨트랙트 주소
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // kittyContract라는 kittyInterface를 생성 + ckAddress를 이용하여 초기화.
    KittyInterface kittyContract = KittyInterface(ckAddress);
    // kittyContract는 다른 컨트랙트를 가리키고 있다.

    // 먹이를 먹고 번식하는 능력 부여 함수  + 세번째  _species 인자를 추가함
    function feedAndMultiply(uint _zombieId, uint _targetDna string _species) public {
    // 좀비주인만 먹이를 주는 require구문을 추가
    // msg.sender가 좀비 주인과 동일하도록
    require(msg.sender == zombieToOwner[_zombieId]);
    // 내 좀비를 zombies 배열에서 + Zobie형 변수를 선언 (storage 포인터 사용!)
    Zombie storage myZombie = zombies[_zombieId];
    // target DNA를 16자리 수로 만듦
    _targetDna = _targetDna % dnaModulus;
    // 먹이먹는좀비의 DNA와 먹이DNA 평균 내기
    unit newDna = (myZombie.dna + _targetDna) / 2;

    //만약 _species가 "kitty" 라면 DNA의 맨 뒷자리를 99로 변환
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
        newDna = newDna - newDna % 100 + 99;
    } 
    // 새로운 DNA값을 얻게 되면 _createZombie함수를 호출
    _createZombie("NoName", newDna); // 새로운 좀비이름은 일단 "NoName"지정
  }

    // 크립토키티 컨트랙트에서 고양이 유전자를 얻어내는 함수
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
      uint kittyDna;
      // 다수의 반환값은 아래처럼 처리
      (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
      feedAndMultiply(_zombieId, kittyDna, "kitty"); // 함수 마지막 인자에 "kitty" 추가
  }

}

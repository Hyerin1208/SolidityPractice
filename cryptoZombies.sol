pragma solidity ^0.4.19;

contract ZombieFactory {

    event NewZombie(uint id, string name, uint dna); // 새로운 좀비 생성시 이벤트

    // 상태 변수는 컨트랙트 저장소에 영구적으로 저장 (아래 변수 )
    uint dnaDigits = 16; // uint는 실제로 uint256 ( 256비트 부호 없는 정수 )// DNA는 16자리수
    uint dnaModulus = 10 ** dnaDigits; // 10의 dnaDigits승

    // 구조체
    struct Zombie {
        string name; // string 자료형,  UTF-8 데이터를 위해 활용
        uint dna;
    }
    // Public 배열 (배열을 읽을 수만 있음 / 공개데이터를 저장할 때 유용)
    Zombie[] public zombies; // zombies는 Zombie로 이루어진 배열

    // 좀비 생성하는 함수선언 (함수명에는 _를 사용하는 관례)
    function _createZombie(string _name, uint _dna) private {
        // 새로운 Zombie구조체 생성, zombies배열에 추가
        zombies.push(Zombie(_name, _dna)); // array.push()는 무언가를 배열의 끝에 추가
    }
    // 랜덤 DNA 숫자를 생성하는 도우미 함수
    // 아래 view 함수 : 데이터를 보기만 하고 변경하지 않는다 // 반환값 종류 uint 포함
    function _generateRandomDna(string _str) private view returns (uint) {
        // _str을 이용한 keccak256 해시값을 받아서 의사 난수 16진수를 생성 + uint로 형 변환
        uint rand = uint(keccak256(_str));
        // 결과 값을 모듈로(%) dnaModulus로 연산한 값을 반환
        return rand % dnaModulus; // 16자리보다 큰 수를 16자리 숫자로 (나머지를 반환하는 %) 
    }

    // 좀비의 이름을 입력값으로 받아 랜덤 DNA를 가진 좀비를 만드는 public 함수
    function _createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
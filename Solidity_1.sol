//  solidity 로 간단한 포인트 시스템 구현.
// [Coin 컨트랙트]
// 컨트랙트 생성자가 관리하는 포인트 시스템 컨트랙트로 포인트 시스템 고유의
// 주소공간(address space)를 가지며 각 주소의 포인트 잔고를 기록한다.
// 컨트랙트 생성자는 사용자 주소(e.g 0xALICE)에 포인트를 부여할 수 있고
// 사용자는 다른 사용자에게 포인트를 전송할 수 있다.
// (e.g. , 0xALICE => 0xBOB, 10 Coins)

// "pragma solidity" 키워드는 Solidity 버전을 지정
pragma solidity ^0.5.6;

// "contract X {...}"는 X라는 컨트랙트를 정의
contract Coin {
    // "minter"는 address 타입으로 선언된 상태;
    // address 타입은 Ethereum에서 사용하는 160-bit주소
    // "public"키워드는 상태를 다른 컨트랙트에서 읽을 수 있도록 허용
    address public minter;

    // "balances"는 mapping타입으로 address타입 데이터를 key로,
    // uint타입 데이터를 value로 가지는 key-value mapping
    // mapping은 타 프로그래밍 언어에서 사용하는 해시테이블 자료구조와 유사
    // (uintialized 값들은 모두 0으로 초기화되어있는 상태)
    mapping (address => uint) public balances;

    // [omitted for brevity]
}

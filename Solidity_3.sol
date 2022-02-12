// N.B. 컨트랙트 함수는 함수를 실행한 TX의 정보를 받을 수 있는데 해당 정보를 msg 변수로 접근

contract Coin {
    // [omitted state variables and event definitions for brecity]

    // 생성자 함수는 컨트랙트가 생성될 때 한번 실행
    // 아래 함수는 minter 상태변수에 msg.sender 값을 대입
    // (함수를 실행한 사람의 주소
    constructor() public {
        minter = msg.sender;
    }

    // [omitted for brecity]
}
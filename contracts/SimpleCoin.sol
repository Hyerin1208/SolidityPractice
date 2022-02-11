pragma solidity ^0.4.0; // 솔리디티 컴파일러의 지원버전

contract SimpleCoin2 {
    // 맴버필드, map자료구조 mapping
    mapping (address => uint256) public coinBalance;

    // 이벤트 로직 추가
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 생성자 + 매개변수 initialSypply 추가
    constructor(uint256 _initialSupply) public {
        // 실제 초기값 세팅
        coinBalance[msg.sender] = _initialSupply;
    }   
    // 메서드
    function transfer(address _to, uint256 _amount) public {
        require(coinBalance[msg.sender] > _amount);
        require(coinBalance[_to] + _amount >= coinBalance[_to] );
        coinBalance[msg.sender] -= _amount;
        coinBalance[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }
}
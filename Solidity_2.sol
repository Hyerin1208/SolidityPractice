contract Coin {
    // [omitted state variavles for brevity]

    // event로 정의된 타입은 클라이언트
    // (e.g., application using a platform-specific SDK/library)가
    // listening 할 수 있는 데이터로 emit 키워드로 해당 타입의 객체를 생성하여
    // 클라이언트에게 정보를 전달
    // usage :
    // /* in Solidity */
    // emit Sent (on_address, other_address, 10);
    // /* in Web3.js */
    // Coin.Sent().watch({}, '', function(err, result) {...});
    event Sent(address form, address to, uint amount);

    // [omitted for brevity]
}
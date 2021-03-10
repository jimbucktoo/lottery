pragma solidity ^0.4.17

contract Lottery {
    address public manager
    address[] public players

    function Lottery() public {
        manager = msg.sender
    }

    function enter() public payable {
        require(msg.value >= 10000000 wei)
        players.push(msg.sender)
    }

    function random() public view returns (uint) {
        //sha3()
        return uint(keccak256(block.difficulty, now, players))
    }

    function pickWinner() public restricted{
        require(msg.sender == manager)
        uint index = random() % players.length
        players[index].transfer(this.balance)
        players = new address[](0)
    }

    modifier restricted() {
        require(msg.sender == manager)
        _
    }

    function getPlayers() public view returns (address[]) {
        return players
    }
}

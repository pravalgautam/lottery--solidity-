// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;



contract lottery{
// involve - manager ,players, winner

address public manager;
address payable[] public players;
address payable public winner;


constructor (){
    manager = msg.sender;
}

function participate() public payable{
    require(msg.value == 1 ether ,"please pay one ether only");
    players.push(payable(msg.sender));
}

  function getBalance() public view returns(uint){
      require(manager==msg.sender,"you are not the manager");
      return address(this).balance;

  }

function random() internal view returns(uint){
    return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,players.length)));
}



function pickWinner() public{
    require(manager==msg.sender,"you are not manager");
   require(players.length>=3,"less no of people");
   uint r =random();
   uint index = r%players.length;
   winner = players[index];
   winner.transfer(getBalance());
   players = new address payable[](0);

}
function allPlayers() public view returns(address payable[] memory){
    return players;
}


}
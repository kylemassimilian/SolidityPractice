pragma solidity >=0.7.0 < 0.9.0;

contract Coin {
    address public minter; 
    mapping (address => uint) public balances;

    //Logs the sent money on the blockchain
    event Sent(address fromt, address to, uint amount);

    //Constructor function executes upon creation or deployment of contract
    constructor(){
        minter = msg.sender;
        //"msg" is a keyword that allows access to special variables that are sent through when the contract is called
        //msg.sender returns the address of the wallet that calls the contract
    } 
    //This function allows the minting of new coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        //Makes sure whoever calls this contract is the minter
        require (amount < 1e60);
        balances[receiver] += amount;
        //Whatever new amount is created by creator of contract will be added to the existing value of the address
    }
    function send(address receiver, uint amount) public {
            require(amount <= balances[msg.sender], "Insufficient balance.");
            balances[msg.sender] -= amount;
            balances[receiver] += amount;
            emit Sent(msg.sender, receiver, amount);
            //Allows us to call event and log info
    }
}

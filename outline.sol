pragma solidity ^0.4.16;

contract ToGen {
  //public variables
  string public name;
  string public symbol;
  uint8 public decimals = 18;
  uint256 public totalSupply;

  //array of balances
  mapping (address => uint256) public balanceOf;

  //generates public event on blockchain that notifies clients
  event Transfer(address indexed from, address indexed to, uint256 value);

  event Burn(address indexed from, uint256 value);

  /*Initializes contract w initial supply tokens to the creator of the contract*/
  function ToGen(
    uint256 initialSupply, 
    string tokenName, 
    string tokenSymbol, 
    uint8 decimalUnits
  ) public {
    balanceOf[msg.sender] = initialSupply; //creator gets all init tokens
    name = tokenName;  //set the name for display purposes
    symbol = tokenSymbol; //set the symbol for display purposes
    decimals = decimalUnits; //amount of decimals for display purposes
  }

  //Internal transfer, can only be called by this contract
  function _transfer (address _from, address _to, uint _value) internal {
    // prevent transfer to 0x0. Use burn() instead
    require(_to !=0x0);
    // check if sender has sufficient funds
    require(balanceOf[_from] >= _value);
    // check for overflows
    require(balanceOf[_to] + _value > balanceOf[_to]);
    // save this for an assertion in the future
    uint previousBalances = balanceOf[_from] + balanceOf[_to];
    // subtract from the sender
    balanceOf[_from] -= _value;
    // add the same to recipient
    balanceOf[_to] += _value;  
    // event call 
    Transfer(_from, _to, _value);
    //apparently, asserts are used to use static analysis to find bugs.
    // should never failll
    assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
  }

  // public transfer function
  function transfer(address _to, uint256 _value) public {
    _transfer(msg.sender, _to, _value);  
  }

  // how is transferFrom different?? is this here for demo?? Administrative??
	// tranfer from lived here

  // like above but pings contract about it
  //approveAndCall

  // destroys tokens
  // removes _value tokens from the system irreversibly
  //burn
  function burn(uint256 _value) public returns (bool success) {
    require(balanceOf[msg.sender] >= _value);
    balanceOf[msg.sender] -= _value;
    totalSupply -= _value;
    Burn(msg.sender, _value);
    return true;  
  }

  //destroys tokens from account
  //burnFrom
}



var _initialSupply =42;
var tokenName= 'ToGen';
var tokenSymbol= 'TGN';
var decimalUnits = 18;


var minter = minterFactory.new( _initialSupply,{from:eth.accounts[0],data:minterCompiled,gas:1000000}, function(e,contract){
	if(!e) {
		
		if(!contract.address){
			console.log("Contract transaction send: TransactionHash: " + contract.transactionHash + " waiting to be mined..")	
		} else {
			console.log("Contract mined! Address: " + contract.address);
			console.log(contract);
		}
	} else {
		console.log(e);	
	}

})

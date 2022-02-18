// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract OmegaToken is ERC20 , Ownable{
    
    address public minter_power_address;
    
    //FIRST MINT
    constructor(string memory name, string memory symbol) ERC20(name, symbol){
        _mint(msg.sender, 5000000*10**18);
    }
    
    //ORDER TO MINT
    function distributionToken(uint _amount, address _to) public{
        require (msg.sender==minter_power_address);
        _mint(_to, _amount);
    }
    
    //SET MAIN ADDRESS
    function  setMainAddress(address _newAddress) public onlyOwner(){
        minter_power_address = _newAddress;
    }
    
}

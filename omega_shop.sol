// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract OmegaShop is Ownable{

    address public OmegaAddress;
    address public BUSDAddress;
    address public VaultAddress;

    mapping(string=>address) public OrderAddress;
    mapping(string=>string) public OrderType;
    mapping(string=>uint) public OrderAmount;

    constructor(address _omega, address _busd, address _vault){
        OmegaAddress = _omega;
        BUSDAddress = _busd;
        VaultAddress = _vault;
    }

    function MakeOrder(string memory _type, uint _amount, string memory _code, string memory _token) public {

        OrderAddress[_code] = msg.sender;
        OrderType[_code] = _type;
        OrderAmount[_code] = _amount;

        if(keccak256(bytes(_token))==keccak256(bytes("omega"))){
            ERC20 omega = ERC20(OmegaAddress);
            omega.transferFrom(msg.sender, VaultAddress, _amount*10**18);
        }else if(keccak256(bytes(_token))==keccak256(bytes("busd"))){
            ERC20 busd = ERC20(BUSDAddress);
            busd.transferFrom(msg.sender, VaultAddress, _amount*10**18);
        }
    }
}

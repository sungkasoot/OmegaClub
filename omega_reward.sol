// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/sungkasoot/OmegaClub/blob/main/omega_token.sol";

contract OmegaSendReward is Ownable{
    
    address public OmegaAddress;
    address public DevAddress;
    uint public TaxIncome;
    //bool public BankEnabled = true;

    mapping(uint=>bool) public WithdrawStatus;

    constructor(address _omega, address _dev){
        OmegaAddress = _omega;
        DevAddress = _dev;
    }

    //SEND REWARD
    function SendReward(uint _amount, uint _tax, address _to) public payable onlyOwner{
        ERC20 omega = ERC20(OmegaAddress);
        uint net = _amount - _tax;
        omega.transfer(_to, net*10**18);
        TaxIncome = TaxIncome + (_tax*10**18);
    }

    //GET OMEGA REMAIN
    function GetOmegaRemain() public view returns(uint){
        ERC20 omega = ERC20(OmegaAddress);
        return omega.balanceOf(address(this));
    }

    //ADMIN ZONE -----------------------------------------------------------------------
    function DistributionOmega() public payable onlyOwner{
        ERC20 omega = ERC20(OmegaAddress);
        omega.transfer(DevAddress, TaxIncome);
        TaxIncome = 0;
    }
/*
    function MoveRewardContract(address _to) public onlyOwner{
        DistributionOmega();

        ERC20 omega = ERC20(OmegaAddress);
        omega.transfer(_to, omega.balanceOf(address(this)));
    }
    */
/*
    function SetBankEnable(bool _new) public onlyOwner{
        BankEnabled = _new;
    }
    */
}

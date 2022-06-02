// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
//import "busd.sol";
import "omega_token.sol";
//import "omega_main.sol";

contract OmegaVault is Ownable{
    
    //uint public part_dev = 9000;
    //uint public part_holder = 1000;
    
    //uint public totaHolderEarn = 0;
    //uint public totalDevEarn = 0;
    
    address public omega_address;
    address public busd_address;
    address public dev_address;
    //address public main_address;
    address public burn_address;
    
    
    constructor(address _dev, address _busd, address _omega){
        //main_address = _main;
        dev_address = _dev;
        busd_address = _busd;
        omega_address = _omega;
        /*
        OmegaMain main = OmegaMain(main_address);
        busd_address = main.busd_address();
        omega_address = main.gov_address();
        */
    }
    
    /*
    function setDevAddress(address _dev) public onlyOwner(){
        dev_address = _dev;
        
        OmegaMain main = OmegaMain(main_address);
        busd_address = main.busd_address();
        omega_address = main.gov_address();
    }
    
    function setMainAddress(address _main) public onlyOwner(){
        main_address = _main;
        
        OmegaMain main = OmegaMain(main_address);
        busd_address = main.busd_address();
        omega_address = main.gov_address();
    }
    
    
    function setRatio(uint _holder) public onlyOwner(){
        require (_holder >= 100);
        
        part_holder = _holder;
        part_dev = 10000 - part_holder;
    }
    */
    function distributionAll() public payable onlyOwner(){
        distributionOMEGA();
        distributionBUSD();
    }
    
    function distributionOMEGA() public payable onlyOwner(){
        //OmegaMain main = OmegaMain(main_address);
        OmegaToken omega = OmegaToken(omega_address);
        
        uint amount = omega.balanceOf(address(this));
        
        //uint amount_dev = amount * part_dev / 10000;
        //uint amount_holder = amount * part_holder / 10000;
        
        omega.transfer(dev_address, amount);
        //omega.transfer(main_address, amount_holder);
        
        //main.addPendingOMEGA(amount_holder);
    }
    
    function distributionBUSD() public payable onlyOwner(){
        //OmegaMain main = OmegaMain(main_address);
        ERC20 busd = ERC20(busd_address);
        
        uint amount = busd.balanceOf(address(this));
        
        //uint amount_dev = amount * part_dev / 10000;
        //uint amount_holder = amount * part_holder / 10000;
        
        busd.transfer(dev_address, amount);
        //busd.transfer(main_address, amount_holder);
        
        //totaHolderEarn = totaHolderEarn + amount_holder;
        //totalDevEarn = totalDevEarn + amount;
        
        //main.addPendingBUSD(amount_holder);
    }
    
    
}

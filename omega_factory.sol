// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OmegaFactory is ERC721, Ownable{
    address public valueAddress;
    address public busdAddress;
    uint public countFactory;
    uint public factoryPrice;
    uint public factoryLimit;
    mapping(string=>uint) public factoriesIdByCode;
    mapping(uint=>string) public factoriesCodeById;

    constructor(string memory _name, string memory _symbol, address _value, address _busd)ERC721(_name, _symbol){
        countFactory = 0;
        busdAddress = _busd;
        valueAddress = _value;
        factoryPrice = 600;
        factoryLimit = 100;
    }

    function MintFactory(string memory _code) public {
        require (countFactory < factoryLimit);

        ERC20 busd = ERC20(busdAddress);
        busd.transferFrom(msg.sender, valueAddress, factoryPrice*10**18);

        uint factoryId = countFactory;

        _mint(msg.sender, factoryId);
        factoriesIdByCode[_code] = factoryId;
        factoriesCodeById[factoryId] = _code;

        countFactory++;
    }

    function SetFactoryPrice(uint _new) public onlyOwner {
        factoryPrice = _new;
    }

    function SetFactoryLimit(uint _new) public onlyOwner {
        factoryLimit = _new;
    }
}

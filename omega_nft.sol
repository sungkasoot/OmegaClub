// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';
import "omega_token.sol";
import "omega_function.sol";

contract OmegaNFT is ERC721, Ownable, DCMFunction {
        
        using Strings for uint256;
        
        uint public NFTCounter;
        uint public teamCounter;
        uint public NFTPrice;
        uint public DP_GashaReward;
        uint public holderRewardPoolBUSD;
        uint public NFTLimit;


        //address public cup_token_address = 0x5f90fe688f6b01CA594C8106CA013fc0E67F063b;
        //address public dev_address = 0x2E6CC51a876ED2b169AA037e827205847224d65f;
        address public main_address;
        
        
        mapping(uint => uint) public mintBlock; //nft_id => currentBlock
        
        //OmegaToken token = OmegaToken(cup_token_address);
        
        
        
        // Optional mapping for token URIs
        mapping (uint256 => string) private _tokenURIs;

        // Base URI
        string private _baseURIextended;


        constructor(string memory _name, string memory _symbol)ERC721(_name, _symbol){

            NFTCounter = 0;
            NFTPrice = 1;
            NFTLimit = 10000;


        }
        
        //MINT NEW
        function mintNew(address _to, uint _nft_id, string memory _nft_uri) public {
            
            require (msg.sender == main_address);
            
            bytes memory tempEmptyStringTest = bytes(_nft_uri); // Uses memory
            if (tempEmptyStringTest.length == 0) {
                revert();
            }
            
            _mint(_to, _nft_id);
            _setTokenURI(_nft_id, _nft_uri);
            mintBlock[_nft_id] = block.number;
            NFTCounter++;
        }
        
        //SET MAIN ADDRESS
        function setMainAddress(address _main) public onlyOwner(){
            main_address = _main;
        }
        
        //SET NFT LIMIT
        function setNFTLimit(uint _new) public onlyOwner(){
            NFTLimit = _new;
        }
        
        //SET TOKEN URI
        function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
            require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
            _tokenURIs[tokenId] = _tokenURI;
        }
        
        function getTokenURI(uint256 tokenId) public view returns(string memory){
            string memory res = _tokenURIs[tokenId];
            return res;
        }
        
        //VIEW NFT URI
        function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
            require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

            string memory _tokenURI = _tokenURIs[tokenId];
            string memory base = _baseURI();
            
            // If there is no base URI, return the token URI.
            if (bytes(base).length == 0) {
                return _tokenURI;
            }
            // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
            if (bytes(_tokenURI).length > 0) {
                return string(abi.encodePacked(base, _tokenURI));
            }
            // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
            return string(abi.encodePacked(base, tokenId.toString()));
        }
        
       
        
        

    }

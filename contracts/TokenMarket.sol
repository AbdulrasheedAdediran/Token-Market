// SPDX-License-Identifier: MIT


pragma solidity 0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract TokenMarket {

    AggregatorV3Interface internal priceFeed;
    IERC20 wavax = IERC20(0x85f138bfEE4ef8e540890CFb48F620571d67Eda3);
    IERC20 usdt = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    event tokenSwap(address from, uint256 amount);
   
     /**
    TOKEN PAIR
     Network: Mainnet
     Aggregator: WAVAX/USDT	
     Decimals: 8	
     Address: 0xFF3EEb22B5E3dE6e705b44749C2559d704923FD7
     */		

    constructor(address tokenPairAddress) {
        priceFeed = AggregatorV3Interface(tokenPairAddress);
    }

    /**
     * Returns the latest price of token pair
     */
    function getLatestPrice() public view returns (int, uint) {
        (
          , int price,,,
           
        ) = priceFeed.latestRoundData();
        uint decimal = priceFeed.decimals(); 
        return (price, decimal);
    }
// Swap WAVAX to USDT
// Amount of WAVAX to be swapped at Current WAVAX price/Current USDT Price
function swapWavaxToUsdt(uint _amount) public returns(uint256 swapAmount){
     (int price, uint decimal) = getLatestPrice();
    uint256 _value = _amount * uint(price) * 10**decimal;
    uint256 div = 10**decimal;
    swapAmount = _value/div;
    wavax.transferFrom(msg.sender, address(this), _amount);
    usdt.transfer(msg.sender, _amount);
    emit tokenSwap(msg.sender, _amount);
}


// // Swap from USDT to WAVAX
// Amount of USDT to be swapped at Current USD price/ Current WAVAX Price
function swapUsdtToWavax(uint256 _amount) public returns(uint256 swapAmount){
    (int256 price, uint decimal) = getLatestPrice();
   uint256  _value = uint256(price);
   swapAmount = (_amount * 10**decimal) / _value;
   usdt.transferFrom(msg.sender, address(this), _amount);
   wavax.transfer(msg.sender, _amount);
   emit tokenSwap(msg.sender, _amount);
}



}

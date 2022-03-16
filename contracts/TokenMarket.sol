// SPDX-License-Identifier: MIT


pragma solidity 0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// contract PriceConsumerV3 {
contract TokenMarket {

    AggregatorV3Interface internal priceFeed;
     
   
     /**
      
    TOKEN PAIR
     Network: Rinkeby
     Aggregator: Token A/Token B
     Aggregator: ETH/USD	
     Decimals: 8	
     Address: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
     */		
    constructor(address tokenPairAddress) {
        priceFeed = AggregatorV3Interface(tokenPairAddress);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int, uint) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        uint decimal = priceFeed.decimals(); 
        return (price, decimal);
    }
// Swap ETH to USD
// Amount of ETH to be swapped at Current ETH price/ Current USD Price
function swapEthToUsd(uint _amount) public view returns(uint _value){

    (int price, uint decimal) = getLatestPrice();
    _value = (uint(price) * _amount) / 10**decimal;
}


// // Swap from USDT to ETH
// Amount of USD to be swapped at Current USD price/ Current ETH Price
function swapUsdToEth(uint _amount, uint8 _precision) public view returns(uint _value){
    (int price, uint decimal) = getLatestPrice();
    _value = ((10**decimal)* _amount * 10**_precision) / uint(price);
}



}

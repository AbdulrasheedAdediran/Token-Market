// SPDX-License-Identifier: MIT


pragma solidity 0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// contract PriceConsumerV3 {
contract TokenMarket {

    AggregatorV3Interface internal priceFeed;

   
     /**
      
    TOKEN PAIR
     Network: Rinkeby
     Aggregator: MATIC/USD	
     Decimals: 8	
     Address: 0x7794ee502922e2b723432DDD852B3C30A911F021
     */		
    constructor(address tokenPairAddress) {
        priceFeed = AggregatorV3Interface(tokenPairAddress);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}

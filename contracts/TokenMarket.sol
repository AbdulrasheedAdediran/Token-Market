// SPDX-License-Identifier: MIT


pragma solidity 0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// contract PriceConsumerV3 {
contract TokenMarket {

    AggregatorV3Interface internal priceFeed;

   
     /**
      
    TOKEN PAIR
     Network: Rinkeby
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

import { ethers } from "hardhat";

async function deployContract() {

    const ETH_USD = "0x8A753747A1Fa494EC906cE90E9f37563A8AF630e";
    const TokenMarket = await ethers.getContractFactory("TokenMarket");
    const token_market = await TokenMarket.deploy(ETH_USD);
    await token_market.deployed();

    console.log("Contract deployed to ", token_market.address);
    

    const latestPrice = await token_market.getLatestPrice();
    const EthToUsd = await token_market.swapEthToUsd(2);
    const precision = 5;
    const UsdToEth = await token_market.swapUsdToEth(5000, precision)
        // ethers.utils.parseEther("2"));
    // ethers.utils.parseEthers()
    
    // Get latest price
    console.log("Latest Price for ETH/USD is", latestPrice);
    console.log("Value of ETH to USD is", EthToUsd);
    console.log("Value of USD to ETH is", parseInt(UsdToEth.toString())/10**precision);


}

deployContract().catch((error) => {
      console.error(error);
      process.exit(1);
    });
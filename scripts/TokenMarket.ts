import { ethers } from "hardhat";

async function deployContract() {

    const ETH_USD = "0x8A753747A1Fa494EC906cE90E9f37563A8AF630e";
    const TokenMarket = await ethers.getContractFactory("TokenMarket");
    const token_market = await TokenMarket.deploy(ETH_USD);
    await token_market.deployed();

    console.log("Contract deployed to ", token_market.address);
    

    const latestPrice = await token_market.getLatestPrice();
    // Get latest price
    console.log("Latest Price for MATIC/USD is", latestPrice)

}

deployContract().catch((error) => {
      console.error(error);
      process.exit(1);
    });
import { ethers } from "hardhat";

async function deployContract() {

    const MATIC_USD = "0x7794ee502922e2b723432DDD852B3C30A911F021"
    const TokenMarket = await ethers.getContractFactory("TokenMarket")
    const token_market = await TokenMarket.deploy(MATIC_USD)
    await token_market.deployed();

}

deployContract().catch((error) => {
      console.error(error);
      process.exit(1);
    });
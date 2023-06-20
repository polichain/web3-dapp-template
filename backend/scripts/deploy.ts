import { artifacts, ethers } from "hardhat";
import fs from "fs";
import path from "path";
import { Contract } from "ethers";

export async function main() {
    const erc20Factory = await ethers.getContractFactory("MockERC20");

    const erc20 = await erc20Factory.deploy("Mock ERC20 Token", "MOCK", 18);

    console.log("Mock ERC20 Token deployed to:", erc20.address);

    saveFrontendFiles(erc20, "MockERC20");

    const vaultFactory = await ethers.getContractFactory("Vault");

    const vault = await vaultFactory.deploy(erc20.address);

    console.log("Vault deployed to:", vault.address);

    saveFrontendFiles(vault, "Vault");

    return { erc20, vault }
}

function saveFrontendFiles(contract: Contract, name: string) {
	const contractsDir = path.join(__dirname, "..", "..", "frontend", "src", "contracts");
  
	if (!fs.existsSync(contractsDir)) {
        fs.mkdirSync(contractsDir);
	}
  
	fs.writeFileSync(
        path.join(contractsDir, name+"-address.json"),
        JSON.stringify({ contract: contract.address }, undefined, 2)
	);
  
	const ContractArtifact = artifacts.readArtifactSync(name);
  
	fs.writeFileSync(
        path.join(contractsDir, name+".json"),
        JSON.stringify(ContractArtifact, null, 2)
	);
  }

main().then(() => {
    console.log('Everything is up and running!')
}).catch((error) => {
	console.error(error);
	process.exitCode = 1;
});
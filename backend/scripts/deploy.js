const hre = require("hardhat");

async function main() {
	const ContractImovelToken = await hre.ethers.getContractFactory("ImovelToken");
	const ContractSinDAO = await hre.ethers.getContractFactory("SinDAO");

	const contractImovelToken = await ContractImovelToken.deploy();
	await contractImovelToken.deployed();
	console.log("ImovelToken deployed to:", contractImovelToken.address);

	const contractSinDAO = await ContractSinDAO.deploy(contractImovelToken.address);
	await contractSinDAO.deployed();
	console.log("SinDAO deployed to:", contractSinDAO.address);
}

main().catch((error) => {
	console.error(error);
	process.exitCode = 1;
});
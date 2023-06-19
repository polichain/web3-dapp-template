# web3-dapp-template

This repo contains a basic template for developing a Web3 Dapp. It's divided in two main parts: frontend and backend.

The instructions for this template will assume that you have basic programs already installed, like Node.js, Git, an IDE, etc.

Each part has its own README.md file with more detailed information and instructions, but here is a short description:

## Frontend

The frontend is a NextJs App using both data-fetching and sessions templates from Vercel, we also added RainbowKit for better and easier connection with the wallet. Wagmi uses an Hardhat provider as default, but it has an Alchemy and a public provider as well to interact with testnets or even main nets.
It has NextUI and Tailwind preconfigured so you can quickly build pages with the built in components and css.
You also can quickly deploy this template in Vercel!

> Obs.: Wagmi has a bunch of other preinstalled provider which you can use as well, but they are not previusly configured.

## Backend

Backend part includes two example contracts, with deploy.js file an example tests pre-configured.
Hardhat is configured to easily deploy localy (on a hardhat node), in the Sapolia Testnet, and, of course, Ethereum Mainnet.

# Thank you!

This project, as any other, have room for improvement. And, of course, Web3 evolves fast, and we want to always keep it up to date, so feel free to sugest improvements, updates, adding lacking information and etc.

Star the repo to support the work! :D
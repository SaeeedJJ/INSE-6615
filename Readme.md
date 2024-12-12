Project: Cat Art Token (CAT)
Overview
The Cat Art Token (CAT) is an ERC-721-compliant NFT smart contract that allows the minting, burning, and management of unique tokens. Built using Solidity and OpenZeppelin libraries, this contract emphasizes security, scalability, and ease of use for developers and collectors.

Features
Minting:
Single token minting with custom URIs.
Batch minting to create multiple tokens in one transaction.
Roles and Permissions:
MINTER_ROLE to grant minting rights.
PAUSER_ROLE to pause/unpause contract operations.
DEFAULT_ADMIN_ROLE to manage other roles.
Customization:
Set base URI and minting price dynamically.
Update the maximum token supply with constraints.
Security:
ReentrancyGuard to prevent reentrancy attacks.
Pausable functionality for emergency response.
Fallback and Receive Functions:
Handles unexpected transactions and logs relevant events.
Burning:
Tokens can be burned by their respective owners.
Deployment Steps
Clone the Repository:

bash
Copy code
git clone https://github.com/username/repository-name.git
cd repository-name
Install Dependencies: Ensure you have Node.js and Hardhat installed:

bash
Copy code
npm install
Configure Environment Variables: Create a .env file in the root directory and include the following:

vbnet
Copy code
PRIVATE_KEY=your-private-key
INFURA_API_KEY=your-infura-api-key
Compile the Contract: Compile the Solidity code to ensure no errors:

bash
Copy code
npx hardhat compile
Deploy the Contract: Run the deployment script provided in the repository:

bash
Copy code
npx hardhat run scripts/deploy.js --network your-network
Verify Deployment (Optional): Use Etherscan or a block explorer to verify the deployed contract:

bash
Copy code
npx hardhat verify --network your-network DEPLOYED_CONTRACT_ADDRESS
Usage
To mint an NFT, call the safeMint function with the token ID and URI.
Use the batchMint function to mint multiple NFTs in one transaction.
Update the mint price or max supply using the setMintPrice and setMaxSupply functions (owner only).
Pause or unpause the contract for emergency scenarios using pause or unpause.
Events
Mint: Logs each minting action with details.
Withdrawal: Logs when the owner withdraws funds.
FallbackTriggered: Logs any fallback function calls.
Received: Logs direct payments to the contract.

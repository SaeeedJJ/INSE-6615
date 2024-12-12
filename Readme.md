# NFT-Based Intellectual Property Management

## Introduction

The **NFT-Based Intellectual Property Management** project leverages blockchain technology to create a decentralized, transparent, and secure system for managing intellectual property rights. Using NFTs (Non-Fungible Tokens), the project allows creators to tokenize their intellectual assets, such as art, music, and written works, while ensuring ownership authenticity and traceability.

This project employs Ethereum’s ERC-721 standard for NFT creation and integrates access control mechanisms to safeguard assets. The solution provides creators with a reliable platform to mint, transfer, and manage their intellectual property rights, promoting innovation and reducing infringement risks.

---

## Project Setup for Remix

### 1. **Clone the Repository**
   Clone the project repository to your local machine:
   ```bash
   git clone <repository-url>
   cd nft-ip-management
```
### 2. **Open Remix**
Go to Remix IDE in your web browser.

### 3. **Create a New File**
In the file explorer on the left, create a new file (MyToken.sol).
Copy and paste your smart contract code into this file.(My file name is NFT Price2.4.sol)

### 4. **Install Dependencies**
Since your contract uses OpenZeppelin libraries, you need to import them. Remix supports importing directly from OpenZeppelin's GitHub repository. For example:
```bash
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
```
### 5. **Compile the Contract**

Navigate to the "Solidity Compiler" tab (icon of a compiler).
Select the appropriate compiler version (e.g., 0.8.20).
Click Compile MyToken.sol.

### 6.**Deploy the Contract**

Go to the "Deploy & Run Transactions" tab (icon of a play button).
In the "Environment" dropdown, select one of the following:
JavaScript VM: A simulated blockchain for testing purposes.
Injected Web3: Connect to MetaMask to deploy on a real testnet or mainnet.
Web3 Provider: Connect to a custom provider like Infura or Alchemy.
I used Sepolia Network test with Metamask

### 7.**RUN**
Fill in the constructor arguments:
_baseTokenURI: Enter a base URI for your NFT metadata (e.g., https://pinata.cloud).
_maxSupply: Specify the maximum number of NFTs.
initialOwner: Enter your wallet address as the owner.
Click Deploy.

### 8.**Interact with the Contract**
After deployment, your contract will appear under the "Deployed Contracts" section.
Expand it to see the available functions, such as safeMint, batchMint, setMintPrice, etc.
Call these functions as needed. For example:
Mint a Token: Call safeMint with the recipient address, token ID, and metadata URI.
Set Mint Price: Use setMintPrice to define the minting cost.
Withdraw Funds: Use withdraw to transfer the contract balance to the owner.

### 9.**Connect to a Testnet**
If deploying to a testnet (Sepolia), ensure your MetaMask wallet is configured for the testnet and has test ETH.
Select Injected Web3 in the deployment environment, and Remix will automatically connect to your MetaMask account.
Deploy and interact with the contract as described above.

### .**Benefits of Using Remix**
Web-Based: No local setup required.
Built-In Debugging: Tools for testing and debugging transactions.
Quick Deployment: Deploy directly to testnets or mainnets via MetaMask.

**.Depoyed NFT on Opensea Testnet**
https://testnets.opensea.io/0x2ef3F12427171Ca9CDDcA24238ce9bdBe4848D7B


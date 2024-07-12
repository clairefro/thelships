# The L Ships

Off the chart.

example collection on testnet: https://testnets.opensea.io/ja/collection/thelships-q38hhm0bip

## Config

`STAGING_ALCHEMY_API_URL`

From app in Alchemy dashabord. Used for Staging app.

`PROD_ALCHEMY_API_URL`

From app in Alchemy dashabord. Used for Prod app.

`PRIVATE_KEY`

From metamask wallet (use test account...)

`ETHERSCAN_API_KEY`

Needed for running `yarn verifiy:rinekby`

`COIN_MARKET_CAP_API_KEY`

(For testing only) Used to fetch current ETH price for `hardhat-gas-reporter`

## Deployment

### NOTE - Do this each deploy to Rinkbey

If you want to have new contract updates reflect in client app, must do the following:

1. Update the **contract address**

1. Update the **abi**

1. Update the `OPENSEA_COLLECTION_URL`

1. Verify etherscan contract (See yarn verify command - must paste in contract address)

(temp client link: https://replit.com/@clairefro/clairefro-nft-project#src/App.jsx)

### Deploys by env:

**Local**

`yarn deploy:dev`

**Rinkeby**

`yarn deploy:rinkeby`

Can view rinkeby NFTs on [testnet OpenSea](https://testnets.opensea.io/). If OpenSea is slow, use Rarible instead:

`https://rinkeby.rarible.com/token/CONTRACT_ADDRESS:TOKEN_ID`

## Dev Tools

**JSONKeeper**

For temporary JSON hosting during dev
https://jsonkeeper.com/

**Rinkeby faucet**

https://faucets.chain.link/rinkeby

**Base64 encoder**

https://www.utilities-online.info/base64

**NFT Token URI previewer**

https://nftpreview.0xdev.codes/

## Contract Graveyard

Some past contract deployment addresses of interest:

0x7D90e1ec06716cEecAfbA09AF1575946589423fd

0x60de9FB8ee0462F86e2301305abC26f40758A61a

## Gratitude

Thanks to [buildspace](https://buildspace.so/) for the web3 lessons and motivation!

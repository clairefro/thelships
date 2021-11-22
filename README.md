# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```

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

## Misc

Protoship:

```json
{
  "name": "The Original L Ship",
  "description": "A protoship",
  "image": "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPHN2ZyB2aWV3Qm94PSIxMjYuNjQ5IDgxLjEzNSAyNDYuNzAyIDE1Ni4zMzIiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgPGRlZnM+CiAgICA8bGluZWFyR3JhZGllbnQgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiIHgxPSIxOTkuMjA5IiB5MT0iODUuNzUyIiB4Mj0iMTk5LjIwOSIgeTI9IjI0Mi4wODQiIGlkPSJncmFkaWVudC0xIiBzcHJlYWRNZXRob2Q9InBhZCIgZ3JhZGllbnRUcmFuc2Zvcm09Im1hdHJpeCgwLjMwMjgzNSwgMC45NTMwNDMsIC0xLjM1NDQzNSwgMC40MzAzNzksIDQwMC4xNDUyOTQsIC01Ny4yMzU1KSI+CiAgICAgIDxzdG9wIG9mZnNldD0iMCIgc3R5bGU9InN0b3AtY29sb3I6IHJnYmEoMjU1LCAxNzgsIDExNSwgMSkiLz4KICAgICAgPHN0b3Agb2Zmc2V0PSIxIiBzdHlsZT0ic3RvcC1jb2xvcjogcmdiYSgyNTUsIDEyMiwgMTMsIDEpIi8+CiAgICA8L2xpbmVhckdyYWRpZW50PgogIDwvZGVmcz4KICA8ZyB0cmFuc2Zvcm09Im1hdHJpeCgxLCAwLCAwLCAxLCAwLjAwMDAwMSwgLTQuNjE3NDE0KSI+CiAgICA8cmVjdCB4PSIxMjYuNjQ5IiB5PSI4NS43NTIiIHdpZHRoPSIyNDYuNzAyIiBoZWlnaHQ9IjE1Ni4zMzIiIHN0eWxlPSJwYWludC1vcmRlcjogZmlsbDsgZmlsbC1ydWxlOiBub256ZXJvOyBmaWxsOiB1cmwoI2dyYWRpZW50LTEpOyIvPgogICAgPHRleHQgc3R5bGU9ImZpbGw6IHJnYigyNTUsIDI1NSwgMjU1KTsgZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDIxcHg7IGZvbnQtd2VpZ2h0OiA3MDA7IHRleHQtdHJhbnNmb3JtOiB1cHBlcmNhc2U7IHdoaXRlLXNwYWNlOiBwcmU7IiB4PSIyMjUuNTA1IiB5PSIxNjguNDk4Ij5TSElQPC90ZXh0PgogIDwvZz4KPC9zdmc+"
}
```

Encoded:

```
data:application/json;base64,ewogICAgIm5hbWUiOiAiVGhlIE9yaWdpbmFsIEwgU2hpcCIsCiAgICAiZGVzY3JpcHRpb24iOiAiQSBwcm90b3NoaXAiLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEQ5NGJXd2dkbVZ5YzJsdmJqMGlNUzR3SWlCbGJtTnZaR2x1WnowaWRYUm1MVGdpUHo0S1BITjJaeUIyYVdWM1FtOTRQU0l4TWpZdU5qUTVJRGd4TGpFek5TQXlORFl1TnpBeUlERTFOaTR6TXpJaUlIaHRiRzV6UFNKb2RIUndPaTh2ZDNkM0xuY3pMbTl5Wnk4eU1EQXdMM04yWnlJK0NpQWdQR1JsWm5NK0NpQWdJQ0E4YkdsdVpXRnlSM0poWkdsbGJuUWdaM0poWkdsbGJuUlZibWwwY3owaWRYTmxjbE53WVdObFQyNVZjMlVpSUhneFBTSXhPVGt1TWpBNUlpQjVNVDBpT0RVdU56VXlJaUI0TWowaU1UazVMakl3T1NJZ2VUSTlJakkwTWk0d09EUWlJR2xrUFNKbmNtRmthV1Z1ZEMweElpQnpjSEpsWVdSTlpYUm9iMlE5SW5CaFpDSWdaM0poWkdsbGJuUlVjbUZ1YzJadmNtMDlJbTFoZEhKcGVDZ3dMak13TWpnek5Td2dNQzQ1TlRNd05ETXNJQzB4TGpNMU5EUXpOU3dnTUM0ME16QXpOemtzSURRd01DNHhORFV5T1RRc0lDMDFOeTR5TXpVMUtTSStDaUFnSUNBZ0lEeHpkRzl3SUc5bVpuTmxkRDBpTUNJZ2MzUjViR1U5SW5OMGIzQXRZMjlzYjNJNklISm5ZbUVvTWpVMUxDQXhOemdzSURFeE5Td2dNU2tpTHo0S0lDQWdJQ0FnUEhOMGIzQWdiMlptYzJWMFBTSXhJaUJ6ZEhsc1pUMGljM1J2Y0MxamIyeHZjam9nY21kaVlTZ3lOVFVzSURFeU1pd2dNVE1zSURFcElpOCtDaUFnSUNBOEwyeHBibVZoY2tkeVlXUnBaVzUwUGdvZ0lEd3ZaR1ZtY3o0S0lDQThaeUIwY21GdWMyWnZjbTA5SW0xaGRISnBlQ2d4TENBd0xDQXdMQ0F4TENBd0xqQXdNREF3TVN3Z0xUUXVOakUzTkRFMEtTSStDaUFnSUNBOGNtVmpkQ0I0UFNJeE1qWXVOalE1SWlCNVBTSTROUzQzTlRJaUlIZHBaSFJvUFNJeU5EWXVOekF5SWlCb1pXbG5hSFE5SWpFMU5pNHpNeklpSUhOMGVXeGxQU0p3WVdsdWRDMXZjbVJsY2pvZ1ptbHNiRHNnWm1sc2JDMXlkV3hsT2lCdWIyNTZaWEp2T3lCbWFXeHNPaUIxY213b0kyZHlZV1JwWlc1MExURXBPeUl2UGdvZ0lDQWdQSFJsZUhRZ2MzUjViR1U5SW1acGJHdzZJSEpuWWlneU5UVXNJREkxTlN3Z01qVTFLVHNnWm05dWRDMW1ZVzFwYkhrNklFRnlhV0ZzTENCellXNXpMWE5sY21sbU95Qm1iMjUwTFhOcGVtVTZJREl4Y0hnN0lHWnZiblF0ZDJWcFoyaDBPaUEzTURBN0lIUmxlSFF0ZEhKaGJuTm1iM0p0T2lCMWNIQmxjbU5oYzJVN0lIZG9hWFJsTFhOd1lXTmxPaUJ3Y21VN0lpQjRQU0l5TWpVdU5UQTFJaUI1UFNJeE5qZ3VORGs0SWo1VFNFbFFQQzkwWlhoMFBnb2dJRHd2Wno0S1BDOXpkbWMrIgp9
```

## Gratitude

Thanks to [buildspace](https://buildspace.so/) for the web3 lessons and motivation!

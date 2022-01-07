# Dixel
A single NFT canvas where users overwrite the previous edition with price-compounded pixels.

## Run Tests
```bash
npx hardhat test
```

## Contracts

### BSC Testnet
- Test token: 0x596b3f42C39aACbB405810D2011BB35b9142c330
- DixelAirdrop: 0x7B0f17dC4A3Bb4AE1880fc195139B5d705e31224
- DixelArt NFT: 0xebb0Ce00EBFAd67180a256aa9592E1a36A61a726
- Dixel contract: 0x0737Ee66D587baB42b42D608C4Fe712B13bbC9f2

## Deploy
```bash
npx hardhat compile

HARDHAT_NETWORK=bscmain node scripts/deploy.js

# Verify source code on Etherscan
npx hardhat verify --network bscmain {contract address} "parameter 1" "parameter 2"
```

## Gas Consumption
```
·-------------------------------------------------|---------------------------|--------------|-----------------------------·
|              Solc version: 0.8.10               ·  Optimizer enabled: true  ·  Runs: 1500  ·  Block limit: 60000000 gas  │
··················································|···························|··············|······························
|  Methods                                        ·                1 gwei/gas                ·       3183.26 usd/eth       │
····························|·····················|·············|·············|··············|···············|··············
|  Contract                 ·  Method             ·  Min        ·  Max        ·  Avg         ·  # calls      ·  usd (avg)  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelAirdrop             ·  addTokens          ·      69360  ·      91316  ·       80338  ·           46  ·       0.26  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelAirdrop             ·  claim              ·          -  ·          -  ·       85131  ·            9  ·       0.27  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelAirdrop             ·  closeAirdrop       ·          -  ·          -  ·       59736  ·            3  ·       0.19  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelAirdrop             ·  startAirdrop       ·          -  ·          -  ·       56134  ·            9  ·       0.18  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelAirdrop             ·  whitelist          ·          -  ·          -  ·      201854  ·           23  ·       0.64  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelArt                 ·  burn               ·          -  ·          -  ·       67688  ·            6  ·       0.22  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelArt                 ·  transferOwnership  ·      28608  ·      28620  ·       28619  ·           58  ·       0.09  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelMock                ·  claimReward        ·      56334  ·      73434  ·       67734  ·            6  ·       0.22  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelMock                ·  updatePixels       ·    1232439  ·    1257317  ·     1251401  ·          100  ·       3.98  │
····························|·····················|·············|·············|··············|···············|··············
|  ERC20PresetMinterPauser  ·  approve            ·      46608  ·      46620  ·       46619  ·          123  ·       0.15  │
····························|·····················|·············|·············|··············|···············|··············
|  ERC20PresetMinterPauser  ·  mint               ·      55830  ·      72954  ·       63456  ·          182  ·       0.20  │
····························|·····················|·············|·············|··············|···············|··············
|  Deployments                                    ·                                          ·  % of limit   ·             │
··················································|·············|·············|··············|···············|··············
|  ColorUtilsMock                                 ·          -  ·          -  ·      298677  ·        0.5 %  ·       0.95  │
··················································|·············|·············|··············|···············|··············
|  DixelAirdrop                                   ·    1400558  ·    1400570  ·     1400569  ·        2.3 %  ·       4.46  │
··················································|·············|·············|··············|···············|··············
|  DixelArt                                       ·    2882174  ·    2882198  ·     2882197  ·        4.8 %  ·       9.17  │
··················································|·············|·············|··············|···············|··············
|  DixelMock                                      ·    7813455  ·    7813479  ·     7813477  ·         13 %  ·      24.87  │
··················································|·············|·············|··············|···············|··············
|  ERC20PresetMinterPauser                        ·          -  ·          -  ·     1951544  ·        3.3 %  ·       6.21  │
·-------------------------------------------------|-------------|-------------|--------------|---------------|-------------·
```

# Dixel
Crowd-sourced pixel art community

## Run Tests
```bash
npx hardhat test
```

## Contracts

### BSC Testnet
- Test token: 0x29F750BD6854B43CB1eeF857452ddC29B9c6C5B5
- Dixel contract: [0xfF202bfD9fd0E5817e7236215B4589b203a3Fcd7](https://testnet.bscscan.com/address/0xfF202bfD9fd0E5817e7236215B4589b203a3Fcd7#code)

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
|  Methods                                        ·                1 gwei/gas                ·       3853.62 usd/eth       │
····························|·····················|·············|·············|··············|···············|··············
|  Contract                 ·  Method             ·  Min        ·  Max        ·  Avg         ·  # calls      ·  usd (avg)  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelArt                 ·  transferOwnership  ·      28596  ·      28620  ·       28618  ·           21  ·       0.11  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelMock                ·  claimReward        ·          -  ·          -  ·       47825  ·            2  ·       0.18  │
····························|·····················|·············|·············|··············|···············|··············
|  DixelMock                ·  updatePixels       ·    1914564  ·    1946795  ·     1936051  ·           30  ·       7.46  │
····························|·····················|·············|·············|··············|···············|··············
|  ERC20PresetMinterPauser  ·  approve            ·      46596  ·      46620  ·       46617  ·           30  ·       0.18  │
····························|·····················|·············|·············|··············|···············|··············
|  ERC20PresetMinterPauser  ·  mint               ·      55830  ·      72954  ·       61542  ·           63  ·       0.24  │
····························|·····················|·············|·············|··············|···············|··············
|  Deployments                                    ·                                          ·  % of limit   ·             │
··················································|·············|·············|··············|···············|··············
|  ColorUtilsMock                                 ·          -  ·          -  ·      298677  ·        0.5 %  ·       1.15  │
··················································|·············|·············|··············|···············|··············
|  DixelArt                                       ·          -  ·          -  ·     2043314  ·        3.4 %  ·       7.87  │
··················································|·············|·············|··············|···············|··············
|  DixelMock                                      ·    7236520  ·    7236532  ·     7236529  ·       12.1 %  ·      27.89  │
··················································|·············|·············|··············|···············|··············
|  ERC20PresetMinterPauser                        ·          -  ·          -  ·     1951544  ·        3.3 %  ·       7.52  │
·-------------------------------------------------|-------------|-------------|--------------|---------------|-------------·
```

# chainlinkVRF2
Chainlink's VRF2 products as standalones. 

This repo contains files used to successfully test Chainlink's VRF2 products as standalones.

* **`A_ChainlinkVRF2.sol`:** Successfully deployed to Avalanche Fuji at [https://testnet.snowtrace.io/address/0xe6d4593f57878231a02d78076ccff67a1ebc771f](0xe6d4593f57878231a02d78076ccff67a1ebc771f). 


The history of the VRF2 subscription queries are available here: https://vrf.chain.link/fuji/631


If you would like to test the contract you will need to import the contract address and abi code into remix and use the **`requestRandomWords()`** function. Once you've paid the gas fees you should be able to call **`s_requestId`** to retrieve the random number.

# Next Steps

* The next milestone is to incorporate Chainlink's AnyAPI, Data feeds, VRF1, and VRF2 into existing blockchain applications and products.
* Include compile tests
* Example usage

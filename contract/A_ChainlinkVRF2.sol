// SPDX-License-Identifier: MIT

/**
 * An example of a consumer contract that relies on a subscription for funding.
 * @link https://docs.chain.link/docs/get-a-random-number/  
 * @link https://vrf.chain.link
 */




pragma solidity ^0.8.12;

import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract ChainlinkVRF is VRFConsumerBaseV2 { 
  VRFCoordinatorV2Interface COORDINATOR;
  LinkTokenInterface LINKTOKEN;

  // Your subscription ID.
  uint64 s_subscriptionId;

  // Fuji Testnet coordinator. For other networks,
  // see https://docs.chain.link/docs/vrf-contracts/#configurations
  address vrfCoordinator = 0x2eD832Ba664535e5886b75D64C46EB9a228C2610;

  // Fuji Testnet LINK token contract. For other networks,
  // see https://docs.chain.link/docs/vrf-contracts/#configurations
  address link = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;

  // The gas lane to use, which specifies the maximum gas price to bump to.
  // For a list of available gas lanes on each network,
  // see https://docs.chain.link/docs/vrf-contracts/#configurations
  bytes32 keyHash = 0x354d2f95da55398f44b7cff77da56283d9c6c829a4bdf1bbcaf2ad6a4d081f61;

  // Depends on the number of requested values that you want sent to the
  // fulfillRandomWords() function. Storing each word costs about 20,000 gas,
  // so 100,000 is a safe default for this example contract. Test and adjust
  // this limit based on the network that you select, the size of the request,
  // and the processing of the callback request in the fulfillRandomWords()
  // function.
  uint32 callbackGasLimit = 100000;

  // The default is 3, but you can set this higher.
  uint16 requestConfirmations = 3;

  // For this example, retrieve 2 random values in one request.
  // Cannot exceed VRFCoordinatorV2.MAX_NUM_WORDS.
  uint32 numWords =  2;

  uint256[] public s_randomWords;
  uint256 public s_requestId;
  address s_owner;

  constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
    COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
    LINKTOKEN = LinkTokenInterface(link);
    s_owner = msg.sender;
    s_subscriptionId = subscriptionId;
  }

  // Assumes the subscription is funded sufficiently.
  function requestRandomWords() external onlyOwner {
    // Will revert if subscription is not set and funded.
    s_requestId = COORDINATOR.requestRandomWords(
      keyHash,
      s_subscriptionId,
      requestConfirmations,
      callbackGasLimit,
      numWords
    );
  }
  
  function fulfillRandomWords(
    uint256, /* requestId */
    uint256[] memory randomWords
  ) internal override {
    s_randomWords = randomWords;
  }

  modifier onlyOwner() {
    require(msg.sender == s_owner);
    _;
  }

 /**
     * Withdraw LINK from this contract
     */
    function withdrawLink() external {
        require(LINKTOKEN.transfer(msg.sender, LINKTOKEN.balanceOf(address(this))), "Unable to transfer");
    }
}

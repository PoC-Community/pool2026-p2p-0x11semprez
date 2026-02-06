// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import {AggregatorV3Interface} from "@chainlink/local/src/data-feeds/interfaces/AggregatorV3Interface.sol";

contract Oracle {
  
  AggregatorV3Interface internal immutable priceFeed;

  constructor(address _priceFeed) {
    priceFeed = AggregatorV3Interface(_priceFeed);
  }

  function getLastestPrice() public view returns(int256) {
    (, int256 answer, , ,) = priceFeed.latestRoundData();
    return answer;
  }

  function getPricein18Decimals() external view returns(uint256) {
    uint256 price = uint256(getLastestPrice());
    return price * 10;
  } 
}

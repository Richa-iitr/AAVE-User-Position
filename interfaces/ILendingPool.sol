// // SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

import {DataTypes} from '../type/DataTypes.sol';

interface ILendingPool {
 
  function getUserAccountData(address user)
    external
    view
    returns (
      uint256 totalCollateralETH,
      uint256 totalDebtETH,
      uint256 availableBorrowsETH,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
    );
}


// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.11;

interface ILendingPoolAddressProvider {
    function getPriceOracle() external view returns (address);
}
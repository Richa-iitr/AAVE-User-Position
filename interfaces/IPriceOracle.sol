// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

interface IPriceOracle {
    function getAssetPrice(address asset) external view returns (uint256);
}

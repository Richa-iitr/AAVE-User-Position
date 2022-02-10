// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.11;
pragma experimental ABIEncoderV2;

import {SafeMath} from "./SafeMath.sol";
import {ILendingPoolAddressProvider} from "../interfaces/ILendingPoolAddressProvider.sol";
import {ILendingPool} from "../interfaces/ILendingPool.sol";
import {IProtocolDataProvider} from "../interfaces/IProtocolDataProvider.sol";
import {IPriceOracle} from "../interfaces/IPriceOracle.sol";
import {AggregatorV3Interface} from "../interfaces/AggregatorV3Interface.sol";
import {tokenData} from "../type/TokenData.sol";

contract AavePosition {
    using SafeMath for uint256;

    constructor() {}

    struct assetData {
        address asset;
        string symbol;
        uint256 borrowRate;
        uint256 supplyRate;
        uint256 LTV;
        uint256 decimal;
        uint256 liquidationThreshold;
        uint256 reserveFactor;
        uint256 price;
        uint256 totalSupply;
        uint256 totalBorrow;
        uint256 maxBorrowLimit;
        uint256 maxLiquidationBorrowLimit;
    }

    address constant LP_CONTR_ADDR = 0x9198F13B08E299d85E096929fA9781A1E3d5d827;
    address constant PD_CONTR_ADDR = 0xFA3bD19110d986c5e5E9DD5F69362d05035D045B;
    address constant LPAP_CONTR_ADDR = 0x178113104fEcbcD7fF8669a0150721e231F0FD4B;

    function getSymbol(address addr)
        internal
        view
        returns (string memory symbol)
    {
        tokenData.TokenData[] memory tokens = IProtocolDataProvider(
            PD_CONTR_ADDR
        ).getAllReservesTokens();
        for (uint256 i = 0; i < tokens.length; i++) {
            if (tokens[i].tokenAddress == addr) {
                symbol = tokens[i].symbol;
            } else {
                symbol = "";
            }
        }
    }

    function getResData(address addr, address owner)
        internal
        view
        returns (
            uint256 supRate,
            uint256 totalsupp,
            uint256 bRate,
            uint256 brs
        )
    {
        uint256 varRate;
        (, , , supRate, varRate, , , , , ) = IProtocolDataProvider(
            PD_CONTR_ADDR
        ).getReserveData(addr);
        uint256 stabBor;
        uint256 varBor;
        uint256 srate;
        (totalsupp, stabBor, varBor, , srate, , , , ) = IProtocolDataProvider(
            PD_CONTR_ADDR
        ).getUserReserveData(addr, owner);
        brs = stabBor.add(varBor);
        if (srate == 0) {
            bRate = varRate;
        } else {
            bRate = srate;
        }
    }

    function getAaveV2Position(address owner, address[] memory tokenAddresses)
        external
        view
        returns (
            uint256 totalCollateralETH,
            uint256 totalBorrows,
            uint256 availableBorrowsETH,
            uint256 currentLiquidationThreshold,
            uint256 ltv,
            uint256 healthFactor,
            assetData[] memory data
        )
    {
        (
            totalCollateralETH,
            totalBorrows,
            availableBorrowsETH,
            currentLiquidationThreshold,
            ltv,
            healthFactor
        ) = ILendingPool(LP_CONTR_ADDR).getUserAccountData(owner);

        address PRICEORACLE_ADDR = ILendingPoolAddressProvider(LPAP_CONTR_ADDR)
            .getPriceOracle();

        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            data[i].asset = tokenAddresses[i];
            data[i].symbol = getSymbol(tokenAddresses[i]);
            (
                data[i].decimal,
                data[i].LTV,
                data[i].liquidationThreshold,
                ,
                data[i].reserveFactor,
                ,
                ,
                ,
                ,

            ) = IProtocolDataProvider(PD_CONTR_ADDR)
                .getReserveConfigurationData(tokenAddresses[i]);

            (
                data[i].supplyRate,
                data[i].totalSupply,
                data[i].borrowRate,
                data[i].totalBorrow
            ) = getResData(tokenAddresses[i], owner);

            data[i].maxBorrowLimit = (data[i].totalSupply).mul(data[i].LTV);
            data[i].maxLiquidationBorrowLimit = (data[i].totalSupply).mul(
                data[i].liquidationThreshold
            );
            data[i].price = IPriceOracle(PRICEORACLE_ADDR).getAssetPrice(
                data[i].asset
            );
        }
    }
}

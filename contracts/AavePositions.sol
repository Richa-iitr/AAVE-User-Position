// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "hardhat/console.sol";
import {ILendingPoolAddressesProvider} from "../interfaces/ILendingPoolAddressesProvider.sol";
import {IERC20Detailed} from "../interfaces/IERC20Detailed.sol";
import {SafeMath} from "./SafeMath.sol";
import {ILendingPool} from "../interfaces/ILendingPool.sol";
import {IProtocolDataProvider} from "../interfaces/IProtocolDataProvider.sol";
import {IPriceOracle} from "../interfaces/IPriceOracle.sol";

contract AavePositions{
    using SafeMath for uint256;

    struct assetData {
        address asset;
        string symbol;
        uint256 borrowRate;
        uint256 supplyRate;
        uint256 ltv;
        uint256 decimal;
        uint256 liquidationThreshold;
        uint256 reserveFactor;
        uint256 price;
        uint256 totalSupply;
        uint256 totalBorrow;
        uint256 maxBorrowLimit;
        uint256 maxLiquidationBorrowLimit;
    }

    /*
    @dev the function to get userDetails
    @params owner- address of the user whose details are needed
    @returns totalCollateralETH-total supplies, totalDebtETH- total borrows, availableBorrows- available borrows, currentLiquidationThreshold, loanToValue, healthfactor
    */
    function userData(address owner) internal view returns (
        uint256 totalCollateralETH,
        uint256 totalDebtETH, 
        uint256 availableBorrowsETH, 
        uint256 currentLiquidationThreshold, 
        uint256 ltv,
        uint256 healthFactor) {

            //Address of lendingPool contract deployed at polygon mumbai 
            address LENDINGPOOL_ADDR = 0x9198F13B08E299d85E096929fA9781A1E3d5d827;
            (totalCollateralETH,totalDebtETH,availableBorrowsETH,currentLiquidationThreshold,ltv,healthFactor) = ILendingPool(LENDINGPOOL_ADDR).getUserAccountData(owner);
    }

    /*
    @returns the symbol of asset 
    @params token: address of the asset
    */
    function getSymbol(address token) internal view returns (string memory symbol) {
        symbol = IERC20Detailed(token).symbol();
    }

    /*
    @dev function to get the details of an asset owned by user
    @param address of owner and token 
    @returns supplyRate, borrowRate,total borrows and total supplies
    */
    function getOwnerReserveData(address owner, address token) internal view returns (
        uint256 supplyRate,
        uint256 borrowRate,
        uint256 totalsupplies,
        uint256 totalBorrows) {
            
            address DATAPROVIDER_ADDR = 0xFA3bD19110d986c5e5E9DD5F69362d05035D045B;
            uint256 _variableRate;
            (,,,supplyRate,_variableRate,,,,,) = IProtocolDataProvider(DATAPROVIDER_ADDR).getReserveData(token);

            uint256 _stableBorrow;
            uint256 _varBorrow;
            uint256 _stableRate;
            (totalsupplies, _stableBorrow, _varBorrow,,,_stableRate,,,) = IProtocolDataProvider(DATAPROVIDER_ADDR).getUserReserveData(token, owner);

            totalBorrows = _stableBorrow.add(_varBorrow);
            if(_stableRate == 0) {
                borrowRate = _variableRate;
            } else {
                borrowRate = _stableRate;
            }
    }

    /*
    @dev function to give the price of token from latest price oracle
    @param address of the token
    @returns price of the asset
    */
    function getPrice(address token) internal view returns (
        uint256 price) {

            address LPAP_ADDR = 0x178113104fEcbcD7fF8669a0150721e231F0FD4B;
            address PRICEORACLE = ILendingPoolAddressesProvider(LPAP_ADDR).getPriceOracle();
            price = IPriceOracle(PRICEORACLE).getAssetPrice(token);
    }

    /*
    @dev function to get details of user including details of owned asset
    @params address of owner and addresses of tokens for which details are needed
    @returns total supplies, total borrows, available borrows, liquidation threshold, ltv, hf, details of assets(address, symbol, borrowRate, supplyRate, ltv, decimal, liquidity threshold, reserveFactor, price, total supply, total borrow, max borrow limit, max liquidity borrow limit)
    */
    function getAaveV2Position(address owner, address[] memory tokenAddresses) external view returns (
        uint256 totalCollateralETH,
        uint256 totalBorrows,
        uint256 availableBorrowsETH,
        uint256 currentLiquidationThreshold,
        uint256 ltv,
        uint256 healthFactor,
        assetData[] memory data) {

            address DATAPROVIDER_ADDR = 0xFA3bD19110d986c5e5E9DD5F69362d05035D045B;
            (totalCollateralETH,totalBorrows,availableBorrowsETH,currentLiquidationThreshold,ltv,healthFactor) = userData(owner);
            data = new assetData[](tokenAddresses.length);

            for(uint256 i=0; i < tokenAddresses.length; i++) {
                assetData memory asset;
                asset.asset = tokenAddresses[i];
                asset.symbol = getSymbol(tokenAddresses[i]);
                (asset.decimal,asset.ltv,asset.liquidationThreshold,,asset.reserveFactor,,,,,) = IProtocolDataProvider(DATAPROVIDER_ADDR).getReserveConfigurationData(tokenAddresses[i]);
                (asset.supplyRate,asset.borrowRate,asset.totalSupply,asset.totalBorrow) = getOwnerReserveData(owner, tokenAddresses[i]);
                asset.maxBorrowLimit = (asset.totalSupply).mul(asset.ltv);
                asset.maxLiquidationBorrowLimit = (asset.totalSupply).mul(asset.liquidationThreshold);
                asset.price = getPrice(tokenAddresses[i]);
                data[i] = asset;
            }
            return (totalCollateralETH, totalBorrows, availableBorrowsETH, currentLiquidationThreshold, ltv, healthFactor, data);            
    }
}
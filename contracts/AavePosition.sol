// // SPDX-License-Identifier: agpl-3.0
// pragma solidity 0.8.11;
// pragma experimental ABIEncoderV2;

// import "hardhat/console.sol";
// import {SafeMath} from "./SafeMath.sol";
// import {ILendingPoolAddressesProvider} from "../interfaces/ILendingPoolAddressesProvider.sol";
// import {ILendingPool} from "../interfaces/ILendingPool.sol";
// import {IProtocolDataProvider} from "../interfaces/IProtocolDataProvider.sol";
// import {IPriceOracle} from "../interfaces/IPriceOracle.sol";
// import {AggregatorV3Interface} from "../interfaces/AggregatorV3Interface.sol";
// import {tokenData} from "../type/TokenData.sol";

// contract AavePosition {
//     using SafeMath for uint256;

//     constructor() {
//         console.log("abc");
//     }

//     // struct assetData {
//     //     address asset; 
//     //     string symbol;
//     //     uint256 borrowRate;
//     //     uint256 supplyRate;
//     //     uint256 LTV;
//     //     uint256 decimal;
//     //     uint256 liquidationThreshold;
//     //     uint256 reserveFactor;
//     //     uint256 price;
//     //     uint256 totalSupply;
//     //     uint256 totalBorrow;
//     //     uint256 maxBorrowLimit;
//     //     uint256 maxLiquidationBorrowLimit;
//     // }

//     address constant LP_CONTR_ADDR = 0x9198F13B08E299d85E096929fA9781A1E3d5d827;
//     address constant PD_CONTR_ADDR = 0xFA3bD19110d986c5e5E9DD5F69362d05035D045B;
//     address constant LPAP_CONTR_ADDR = 0x178113104fEcbcD7fF8669a0150721e231F0FD4B;

//     // function getSymbol(address addr) internal view returns (string memory symbol) {
        
//     //     tokenData.TokenData[] memory tokens = IProtocolDataProvider( PD_CONTR_ADDR).getAllReservesTokens();
//     //     console.log(tokens.length);
//     //     for (uint256 i = 0; i < tokens.length; i++) {
//     //         if (tokens[i].tokenAddress == addr) {
//     //             symbol = tokens[i].symbol;
//     //         } else {
//     //             symbol = "";
//     //         }
//     //     }
//     //     return symbol;
//     // }

//     // function getResData(address addr, address owner)
//     //     internal
//     //     view
//     //     returns (
//     //         uint256 supRate,
//     //         uint256 totalsupp,
//     //         uint256 bRate,
//     //         uint256 brs
//     //     )
//     // {
//     //     uint256 varRate;
//     //     (, , , supRate, varRate, , , , , ) = IProtocolDataProvider(
//     //         PD_CONTR_ADDR
//     //     ).getReserveData(addr);

//     //     console.log(supRate);
//     //     console.log(varRate);

//     //     uint256 stabBor;
//     //     uint256 varBor;
//     //     uint256 srate;
//     //     (totalsupp, stabBor, varBor, , srate, , , , ) = IProtocolDataProvider(
//     //         PD_CONTR_ADDR
//     //     ).getUserReserveData(addr, owner);
//     //     brs = stabBor.add(varBor);
//     //     if (srate == 0) {
//     //         bRate = varRate;
//     //     } else {
//     //         bRate = srate;
//     //     }
//     // }

//     function getAaveV2Position(address owner, address[] memory tokenAddresses)
//         external
//         view
//         returns (
//             address addr
//             // uint256 totalCollateralETH,
//             // uint256 totalDebtETH,
//             // uint256 availableBorrowsETH,
//             // uint256 currentLiquidationThreshold,
//             // uint256 ltv,
//             // uint256 healthFactor
//             // assetData[] memory tokenDatas
//         )
//     {
//         console.log(tokenAddresses[0]);
//         (addr) = ILendingPoolAddressesProvider(LPAP_CONTR_ADDR).getPriceOracle();
//         // (totalCollateralETH,totalDebtETH,availableBorrowsETH,currentLiquidationThreshold,ltv,healthFactor) = ILendingPool(LP_CONTR_ADDR).getUserAccountData(owner);
//         // return (1000,2,3,4,5,6);
//         // uint256 a; bool b;

//         //             (a,
//         //         tokenDatas[0].decimal,
//         //         tokenDatas[0].LTV,
//         //         tokenDatas[0].liquidationThreshold,
//         //         tokenDatas[0].reserveFactor,
//         //         b,
//         //         b,
//         //         b,
//         //         b,b

//         //     ) = IProtocolDataProvider(PD_CONTR_ADDR)
//         //         .getReserveConfigurationData(tokenAddresses[0]);
//         //     console.log(tokenDatas[0].asset);
//         // // (
//         // //     totalCollateralETH,
//         // //     totalBorrows,
//         // //     availableBorrowsETH,
//         // //     currentLiquidationThreshold,
//         // //     ltv,
//         // //     healthFactor
//         // // ) = ILendingPool(LP_CONTR_ADDR).getUserAccountData(owner);
//         // // console.log(LP_CONTR_ADDR);
//         // // uint256 a;
//         // // (a,a,a,a,a,a) = ILendingPool(LP_CONTR_ADDR).getUserAccountData(owner);
//         // // totalCollateralETH = data[0];
//         // // totalBorrows = data[1];
//         // console.log("nhg");
//         // console.log(tokenAddresses.length);
//         // // console.log(a);
//         // console.log(totalCollateralETH);
//         // // address PRICEORACLE_ADDR = ILendingPoolAddressesProvider(LPAP_CONTR_ADDR)
//         // //     .getPriceOracle();
//         // // for (uint256 i = 0; i < tokenAddresses.length; i++) {
//         // //     tokenDatas[i].asset = tokenAddresses[i];
//         // //     // tokenDatas[i].symbol = getSymbol(tokenAddresses[i]);
//         // //     (
//         // //         tokenDatas[i].decimal,
//         // //         tokenDatas[i].LTV,
//         // //         tokenDatas[i].liquidationThreshold,
//         // //         ,
//         // //         tokenDatas[i].reserveFactor,
//         // //         ,
//         // //         ,
//         // //         ,
//         // //         ,

//         // //     ) = IProtocolDataProvider(PD_CONTR_ADDR)
//         // //         .getReserveConfigurationData(tokenAddresses[i]);
//         // //     console.log(tokenDatas[i].asset);
//         // //     (
//         // //         tokenDatas[i].supplyRate,
//         // //         tokenDatas[i].totalSupply,
//         // //         tokenDatas[i].borrowRate,
//         // //         tokenDatas[i].totalBorrow
//         // //     ) = getResData(tokenAddresses[i], owner);

//         // //     tokenDatas[i].maxBorrowLimit = (tokenDatas[i].totalSupply).mul(
//         // //         tokenDatas[i].LTV
//         // //     );
//         // //     tokenDatas[i].maxLiquidationBorrowLimit = (
//         // //         tokenDatas[i].totalSupply
//         // //     ).mul(tokenDatas[i].liquidationThreshold);
//         // //     // tokenDatas[i].price = IPriceOracle(PRICEORACLE_ADDR).getAssetPrice(
//         // //     //     tokenAddresses[i]
//         // //     // );
//         // // }
//     }
// }




// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperCofig} from "./helper.config.s.sol";
contract DeployFundMe is Script{
    function run() external returns(FundMe){
        //Before broadcast--->not a txn
        HelperCofig HelperCofig=new HelperCofig();
        (address ethUsfPriceFeed)=HelperCofig.activeNetworkConfig();
        vm.startBroadcast();
        FundMe fundMe=new FundMe();
        vm.stopBroadcast();
        return fundMe;
    }

}
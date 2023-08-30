// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;
//deploy mocks when we are on a local anvil chain
// keep track of contract address across different chains
//sepolia eth/usd
//mainnet eth/usd

contract HelperCofig is Script {
    //magic nmbers from mockv3aggregator
    uint8 public constant DECIMALS=8;
    int256 public constant INITIAL_PRICE=2000e8;

    NetworkConfig public activeNetworkConfig;
    //if we are on local anvil we use mocks otherwise paste the address from the live ones
    struct NetworkConfig{
        address priceFeed;//ETH/USD price feed
    }
    constructor(){
        if(block.chainid==11155111){
            activeNetworkConfig=getSepoliaEthConfig();
        }
        else{
            activeNetworkConfig=getAnvilEthConfig();
        }
    }
    function getSepoliaEthConfig() public pure returns(NetworkConfig memory){
        //price feed address
        NetworkConfig sepoliaConfig=NetworkConfig({priceFeed: "address"});
        return sepoliaConfig;
    }
    function getAnvilEthConfig() public returns(NetworkConfig memory){
        //price feed address
        //1.Deplpy the ,mocks
        //2, return the mock address
        vm.startBroadcast();
        //MockV3Aggregator mockPriceFeed=new MOckV3 aggregator(8,2000e8)
        vm.stopBroadcast();
        NetworkConfig memory anvilConfig =NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilConfig;
    }
}
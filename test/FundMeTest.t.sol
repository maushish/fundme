// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from"../script/DeployFundMe.s.sol";
contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external{
        DeployFundMe deployFundMe=new DeployFundMe();
        fundMe=deployFundMe.run();
        }
    function testMinimumDollarIsFive() public{
        assertEq(fundMe.MINIMUM_USD(),5e18);
       
    }
    function testOwnerIsMsgSender() public{
        console.log(fundMe.i_owner);
        console.log(msg.sender);
        assertEq(fundMe.i_owner(),msg.sender);
    }
    function testPriceFeedVersionIsAccurate() public{
        uint256 version=fundMe.getVersion();
        assertEq(version, 4);
    }
    function testFundFailsWithoutEnoughETH()public{
        vm.expectRevert(); //the next line should revert!
        //assert(this tx fails/reverts)
        fundMe.fund();//send 0 value;
    }
    function testFundUpdatesFUndedDataStruct() public{
        fundMe.fund{value:10e18}();
        
    }//getters functions (view/pure)
    function testFunUpdatesFUndedDataStructure() public{
        vm.prank(USER);//the next tx will be sent by user
        fundMe.fund{value:10e18}();
        uint256 amountFunded=fundMe.getAddressToAmountFunded(USER);
        assrtEq(amountFunded,10e18);
    }   //use deal cheatcode to send fake money
    modifier funded(){
        vm.prank(USER);
        fundme.fund{value:SEND_VALUE};
        _;
    }

    function testAddsFunderTOarrayOfFunders()public{
        vm.prank(USER);
        fundMe.fund{value:SEND_VALUE}();
        adress funder=fundMe.getFUnder(0);
        assertEq(funder, USER);
    }   
    function  testWithDrawWithASingleFunder() public funded{
        //Arrange
        uint256 startingOwnerBalance=fundMe.getOwner().balance;
        // act 
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();
        //assert 
        uint256 endingOwnerBalance= fundMe.getOwner().balance;
        uint256 endingFundMeBalance=address(fundME).balance;
        assertEq(endingFundMeBalance,0);


    }
}
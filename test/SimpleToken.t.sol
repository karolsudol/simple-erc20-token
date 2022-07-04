// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "../src/SimpleToken.sol";
contract SimpleTokenTest is Test {
    // Target contract
    SimpleToken simpleToken;
    // Actors
    address owner;
    address ZERO_ADDRESS = address(0);
    address spender = address(1);
    address user = address(2);
    // Test params
    string public name = "My Token";
    string public symbol = "MTKN";
    uint256 public decimals = 18;
    uint256 amount = 1000 * 1e18;
    uint256 public initialSupply = 1000 * 1e18;
    event Transfer(address indexed from, address indexed to, uint256 value);
    //  =====   Set up  =====
    function setUp() public {
        owner = address(this);
        simpleToken = new SimpleToken();
    }
    //  =====   Initial state   =====
    /**
     *  @dev Tests the relevant initial state of the contract.
     *
     *  - Token name is 'My Token'
     *  - Token symbol is 'MTKN'
     *  - Token initail supply is '1000000000000000000000'
     *  - Token decimals is '18'
     */
    function testinitialState() public {
        // assert if the corrent name was used
        assertEq(simpleToken.name(), name);
        // assert if the correct symbol was used
        assertEq(simpleToken.symbol(), symbol);
        // assert if the correct initial supply was set
        assertEq(simpleToken.totalSupply(), initialSupply);
        // assert if the correct decimal was set
        assertEq(simpleToken.decimals(), decimals);
    }
    //  =====   Functionality tests   =====
    /// @dev Test `mint`
    // Only Owner should be able to mint
    function testFailUnauthorizedMinter() public {
        vm.prank(user);
        simpleToken.mint(user, amount);
    }
    // Should not be able to mint to the zero address
    function testFailMintToZeroAddress() public {
        vm.prank(owner);
        simpleToken.mint(ZERO_ADDRESS, amount);
    }
    // Should increase total supply
    function testIncreseTotalSupply() public {
        uint256 expectedSupply = initialSupply + amount;
        vm.prank(owner);
        simpleToken.mint(owner, amount);
        assertEq(simpleToken.totalSupply(), expectedSupply);
    }
    // Should increase recipient balance
    function testIncreaseRecipientBalance() public {
        vm.prank(owner);
        simpleToken.mint(user, amount);
        assertEq(simpleToken.balanceOf(user), amount);
    }
    // Should emit Transfer event
    function testEmitTransferEventForMint() public {
        vm.expectEmit(true, true, false, true);
        emit Transfer(ZERO_ADDRESS, user, amount);
        vm.prank(owner);
        simpleToken.mint(user, amount);
    }
}
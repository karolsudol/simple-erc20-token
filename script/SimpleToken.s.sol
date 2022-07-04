// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/SimpleToken.sol";

contract SimpleTokenScript is Script {
    // function setUp() public {}

    function run() public {
        vm.startBroadcast();
        SimpleToken simpleToken = new SimpleToken();
        vm.stopBroadcast();
    }
}

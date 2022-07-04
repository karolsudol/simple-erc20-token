// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleToken is ERC20 {
    address public owner;
    constructor() ERC20("Simple Token", "STKN") {
        owner = msg.sender;
        _mint(msg.sender, 1000 * 10**decimals());
    }
    function mint(address account, uint256 amount) public {
        require(msg.sender == owner, "Only Owner can mint");
        _mint(account, amount);
    }
    function burn(address account, uint256 amount) public {
        require(msg.sender == owner, "Only Owner can burn");
        _burn(account, amount);
    }
}
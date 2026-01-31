// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract ETHVault is ReentrancyGuard {

    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Zero ETH not allowed");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external nonReentrant {
        require(amount > 0, "Invalid amount");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "ETH transfer failed");
    }

    function vaultBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

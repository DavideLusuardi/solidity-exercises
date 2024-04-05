// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    mapping(address => uint256) private balance;
    mapping(address => uint256) lastcall;

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        return balance[user];
    }

    function depositEther() external payable {
        balance[msg.sender] += msg.value;
        lastcall[msg.sender] = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
        require(block.timestamp >= lastcall[msg.sender] + 1 weeks, "wait");
        require(balance[msg.sender] >= amount, "amount exceeds balance");
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "transaction failed");
        balance[msg.sender] -= amount;
    }
}

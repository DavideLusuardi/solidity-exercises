// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {

    struct Order {
        uint256 timestamp;
        uint256 amount;
    }

    address public seller;
    mapping(address => Order) orders;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        require(orders[msg.sender].timestamp == 0, "active escrow still exist");
        orders[msg.sender] = Order({timestamp: block.timestamp, amount: msg.value});
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        require(block.timestamp >= orders[buyer].timestamp + 3 days, "wait");
        (bool ok, ) = msg.sender.call{value: orders[buyer].amount}("");
        require(ok, "transfer failed");
        orders[buyer].amount = 0;
        orders[buyer].timestamp = 0;
    }

    /**
     * allows buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(block.timestamp < orders[msg.sender].timestamp + 3 days, "wait");
        (bool ok, ) = msg.sender.call{value: orders[msg.sender].amount}("");
        require(ok, "transfer failed");
        orders[msg.sender].amount = 0;
        orders[msg.sender].timestamp = 0;
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        return orders[buyer].amount;
    }
}

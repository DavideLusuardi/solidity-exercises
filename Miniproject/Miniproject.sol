// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract RareCoin {
    string public name;
    string public symbol;

    mapping(address => uint256) public balanceOf;
    address public owner;
    uint8 public decimals;

    uint256 public totalSupply;

    // owner -> spender -> allowance
    // this enables an owner to give allowance to multiple addresses
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        decimals = 18;
        owner = msg.sender;
    }

    function mint(uint256 amount) public {
        require(msg.sender == owner, "only owner can create tokens");
        totalSupply += amount;
        balanceOf[owner] += amount;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        return helperTransfer(msg.sender, to, amount);
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;

        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        if (msg.sender != from) {
            require(allowance[from][msg.sender] >= amount, "not enough allowance");

            allowance[from][msg.sender] -= amount;
        }

        return helperTransfer(from, to, amount);
    }

    function helperTransfer(address from, address to, uint256 amount) internal returns (bool) {
        require(balanceOf[from] >= amount, "not enough money");
        require(to != address(0), "cannot send to address(0)");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        return true;
    }

    function trade(address SkillsCoinAddress, uint256 yourBalanceOfSkillsCoin) public returns (bool) {
        (bool ok, bytes memory result) = SkillsCoinAddress.call(
            abi.encodeWithSignature("transferFrom(address,address,uint256)", msg.sender, address(this), yourBalanceOfSkillsCoin)
        );
        require(ok, "call failed");

        bool res = abi.decode(result, (bool));
        if (res) {
            balanceOf[msg.sender] += yourBalanceOfSkillsCoin;
        }
        return res;
    }
}


contract SkillsCoin {
    // string public name;
    // string public symbol;

    mapping(address => uint256) public balanceOf;
    address public owner;
    uint8 public decimals;

    uint256 public totalSupply;

    // owner -> spender -> allowance
    // this enables an owner to give allowance to multiple addresses
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        decimals = 18;
        owner = msg.sender;
    }

    function mint(uint256 amount) public {
        // require(msg.sender == owner, "only owner can create tokens");
        totalSupply += amount;
        balanceOf[msg.sender] += amount;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        return helperTransfer(msg.sender, to, amount);
    }

    function approve(address rareCoinAddress, uint256 yourBalanceOfSkillsCoin) public returns (bool) {
        allowance[msg.sender][rareCoinAddress] = yourBalanceOfSkillsCoin;

        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        if (msg.sender != from) {
            require(allowance[from][msg.sender] >= amount, "not enough allowance");

            allowance[from][msg.sender] -= amount;
        }

        return helperTransfer(from, to, amount);
    }

    function helperTransfer(address from, address to, uint256 amount) internal returns (bool) {
        require(balanceOf[from] >= amount, "not enough money");
        require(to != address(0), "cannot send to address(0)");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        return true;
    }
}
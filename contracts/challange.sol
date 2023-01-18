// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract challenge {
    uint private _number;
    uint private _decimals;
    mapping(address => bool) private _users;
    uint private _userCount;
    address private immutable _owner;

    constructor() {
        _owner = msg.sender;
        _decimals = 18;
    }

    function getNumber() external view returns(uint) {
        return _number;
    }

    function getDecimals() external view returns(uint) {
        return _decimals;
    }

    function isUser() external view returns(bool) {
        return _users[msg.sender];
    }

    function getUserCount() external view returns(uint) {
        return _userCount;
    }

    function getOwner() external view returns(address) {
        return _owner;
    }

    function updateValue(uint number) external {
        insertUser(msg.sender);
        _number += number;
    }

    function insertUser(address user) internal virtual returns(bool) {
        if(!_users[user]) {
            _users[user] = true;
            _userCount += 1;
            return true;
        } else {
            return false;
        }
    }
}
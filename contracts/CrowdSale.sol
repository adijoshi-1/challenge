// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Token is ERC20, ERC20Burnable {
    address private _owner;
    address private _allowed;

    constructor() ERC20("My Custom Token", "MCT") {
        _owner = msg.sender;
    }

    function owner() external view returns(address){
        return _owner;
    }

    function allowed() external view returns(address) {
        return _allowed;
    }

    function updateAllowed(address allowed_) external {
        require(msg.sender == _owner, "MCT: Only callable by owner");
        _allowed = allowed_;
    }

    function mintOnCall(address account, uint amount) external {
        require(msg.sender == _allowed, "MCT: Only callable by allowed address");
        _mint(account, amount);
    }
}

contract CrowdSale {
    using SafeMath for uint256;

    address private _wallet;
    address private _token;

    uint private _weiRaised;

    mapping(address => uint) private weiSent;

    constructor(address wallet_, address token_) {
        _wallet = wallet_;
        _token = token_;
    }

    receive() external payable {
        buyTokens(msg.sender);
    }

    function pay() external payable {
        buyTokens(msg.sender);
    }

    function wallet() external view returns(address) {
        return _wallet;
    }

    function token() external view returns(address) {
        return _token;
    }

    function buyTokens(address beneficiary) internal {
        uint weiAmount = msg.value;
        _preValidateTransaction(beneficiary, weiAmount);

        uint tokenAmount = _calculateTokens(weiAmount);
        uint burnTokens = _calculateBurnTokens(tokenAmount);

        _mintNewTokens(beneficiary, tokenAmount);
        _processTransaction(weiAmount, burnTokens);
    }

    function _preValidateTransaction(address beneficiary, uint weiAmount) internal virtual {
        require(beneficiary != address(0), "CrowdSale: Address cannot be 0");
        require(weiAmount != 0, "CrowdSale: Wei Amount is Zero");
        require(weiAmount <= 0.5 ether - weiSent[beneficiary], "CrowdSale: You can only buy tokens worth 0.5 ether");
        require(_weiRaised <= 10 ether, "CrowdSale: Sale has ended");

        weiSent[beneficiary] = SafeMath.add(weiSent[beneficiary], weiAmount);
    }

    function _calculateTokens(uint weiAmount) internal virtual returns(uint) {
        return SafeMath.mul(weiAmount, 1000);
    }

    function _calculateBurnTokens(uint tokenAmount) internal virtual returns(uint) {
        return SafeMath.mul(2, SafeMath.div(tokenAmount, 100));
    }

    function _mintNewTokens(address beneficiary, uint tokenAmount) internal virtual {
        Token token_ = Token(_token);
        token_.mintOnCall(beneficiary, tokenAmount);
    }

    function _sendFunds(uint weiAmount) internal virtual {
        (bool success, ) = payable(_wallet).call{value: weiAmount}("");
        require(success, "Cannot send funds");

        _weiRaised = SafeMath.add(_weiRaised, weiAmount);
    }

    function _burnTokens(uint burnTokens) internal virtual {
        Token token_ = Token(_token);
        token_.burn(burnTokens);
    }

    function _processTransaction(uint weiAmount, uint burnTokens) internal virtual {
        _sendFunds(weiAmount);
        _burnTokens(burnTokens);
    }
}
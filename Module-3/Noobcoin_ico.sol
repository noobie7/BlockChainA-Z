// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Noobcoin_ico {

    // Declaring the max. number of Noobcoins available for sale
    uint public max_noobcoins = 1e9;

    // Declaring USD to NoobCoin conversion rate
    uint public usd_to_noobcoin = 1000;

    // The number of noobcoins that have been bought by the investors
    uint public total_noobcoins_bought = 0;

    // Mapping from the investor address to its equity in noobcoins and USD
    mapping(address => uint) equity_noobcoins;
    mapping(address => uint) equity_usd;

    // Checking if an investor can buy Noobcoins
    modifier can_buy_noobcoins(uint usd_invested){
        require( usd_invested * usd_to_noobcoin + total_noobcoins_bought <= max_noobcoins );
        _;
    }

    // Getting the equity in Noobcoins of an investor
    function equity_in_noobcoins(address investor) external view returns (uint){
        return equity_noobcoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    // Buying Noobcoins
    function buy_NoobCoins(address investor, uint usd_invested) external 
    can_buy_noobcoins(usd_invested) {
        uint noobcoins_bought = usd_invested * usd_to_noobcoin;
        equity_usd[investor] += noobcoins_bought;
        equity_noobcoins[investor] += equity_usd[investor] / usd_to_noobcoin;
        total_noobcoins_bought += noobcoins_bought;
    }

    // Selling Noobcoins
    function sell_NoobCoins(address investor, uint noobcoins_sold) external {
        equity_noobcoins[investor] -= noobcoins_sold;
        equity_usd[investor] += equity_noobcoins[investor] / usd_to_noobcoin;
        total_noobcoins_bought -= noobcoins_sold;
    }
}
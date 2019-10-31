//Omcoins ICO

//Version of compiler
pragma solidity ^0.4.11;

contract omcoin_ico
{
    //Introducing the maximum number of Omcoins available for sale
    uint public max_omcoins = 1000000;
    
    //Introducing the USD to Omcoins conversion rate
    uint public usd_to_omcoins = 1000;
    
    //Introducing the total number of Omcoins that have been bought by the investors
    uint public total_omcoins_bought = 0;
    
    //Mapping from the investor address to its equity in Omcoins and USD
    mapping(address => uint) equity_omcoins;
    mapping(address => uint) equity_usd;
    
    //Checking if an investor can buy Omcoins
    modifier can_buy_omcoins(uint usd_invested)
    {
        require (usd_invested * usd_to_omcoins + total_omcoins_bought <= max_omcoins);
        _;
    }
    
    //Getting the equity in Omcoins of an investor
    function equity_in_omcoins(address investor) external constant returns (uint)
    {
        return equity_omcoins[investor];
    }
    
    //Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint)
    {
        return equity_usd[investor];
    }
    
    //Buying Omcoins
    function buy_omcoins(address investor, uint usd_invested) external
    can_buy_omcoins(usd_invested)
    {
        uint omcoins_bought = usd_invested * usd_to_omcoins;
        equity_omcoins[investor] += omcoins_bought;
        equity_usd[investor] = equity_omcoins[investor] / 1000;
        total_omcoins_bought += omcoins_bought;
    }
    
    //Selling Omcoins
    function sell_omcoins(address investor, uint omcoins_sold) external
    {
        equity_omcoins[investor] -= omcoins_sold;
        equity_usd[investor] = equity_omcoins[investor] / 1000;
        total_omcoins_bought -= omcoins_sold;
    }
    
}
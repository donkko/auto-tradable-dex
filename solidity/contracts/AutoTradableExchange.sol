pragma solidity ^0.4.21;

import "./Exchange.sol";

contract UserStrategyInterface {
    function run(
        string symbolName,
        function (string storage, uint, uint) internal,
        function (string storage, uint, uint) internal,
        uint[] arrPricesBuy,
        uint[] arrVolumesBuy,
        uint[] arrPricesSell,
        uint[] arrVolumesSell
    );
}

contract AutoTradableExchange is Exchange {
    UserStrategyInterface[] strategies;

    function registerStrategy (UserStrategyInterface strategy) {
        strategies.push(strategy);
    }

    function buyToken(string symbolName, uint priceInWei, uint amount) public {
        super.buyToken(symbolName, priceInWei, amount);
        runStrategies(symbolName, super.buyToken, super.sellToken);
    }

    function sellToken(string symbolName, uint priceInWei, uint amount) public payable {
        super.sellToken(symbolName, priceInWei, amount);
        runStrategies(symbolName, super.buyToken, super.sellToken);
    }

    function runStrategies(
        string symbolName,
        function (string storage, uint, uint) internal buyTokenInternal,
        function (string storage, uint, uint) internal sellTokenInternal
    ) {
        (arrPricesBuy, arrVolumesBuy) = getBuyOrderBook(symbolName);
        (arrPricesSell, arrVolumesSell) = getSellOrderBook(symbolName);

        // using oraclize??
        for (uint i; i < strategies.length; i++) {
            strategies[i].run(
                symbolName,
                buyTokenInternal,
                sellTokenInternal,
                arrPricesBuy,
                arrVolumesBuy,
                arrPricesSell,
                arrVolumesSell
            );
        }
    }
}

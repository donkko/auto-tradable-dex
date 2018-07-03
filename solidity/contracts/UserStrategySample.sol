contract UserStrategySample {
    function run(
        string storage symbolName,
        function (string storage, uint, uint) internal buyToken,
        function (string storage, uint, uint) internal sellToken,
        uint[] arrPricesBuy,
        uint[] arrVolumesBuy,
        uint[] arrPricesSell,
        uint[] arrVolumesSell
    ) internal {
        uint highestSellBidIndex = arrPricesSell.length - 1;
        uint highestSellPrice = arrPricesSell[highestSellBidIndex];
        uint highestSellVolumne = arrVolumesSell[highestSellBidIndex];

        if (highestSellPrice <= 1234) {
            buyToken(symbolName, highestSellPrice, highestSellVolumne);
        }
    }
}

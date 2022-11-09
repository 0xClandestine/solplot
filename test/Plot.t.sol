// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Plot.sol";

contract DemoPlot is Plot {
    // Some math to plot out...
    function expToTarget(uint256 initialValue, uint256 targetValue, uint256 index, uint256 epochLength)
        internal
        pure
        returns (uint256 output)
    {
        output = initialValue >> (index / epochLength);
        output -= (output * (index % epochLength) / epochLength) >> 1;
        output += (initialValue - output) * targetValue / initialValue;
    }

    function testPlot_ExpToTarget() public {
        vm.removeFile("input.csv");

        uint128 x = 1e18;
        uint128 e = 10;
        uint128 tv = 0.9e18;

        // Create input csv
        for (uint256 t; t < 100; t++) {

            string[] memory cols = new string[](3);

            cols[0] = vm.toString(t * 1e18);
            cols[1] = vm.toString(expToTarget(x, tv, t, e));
            cols[2] = vm.toString(expToTarget(x, tv, t, e*2));

            writeToCSV("input.csv", cols);
        }

        plotWad("input.csv", "output.svg", 3);
    }
}

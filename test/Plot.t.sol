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

        // Create input csv
        for (uint256 i; i < 100; i++) {

            string[] memory cols = new string[](7);

            if (i == 0) {
                cols[0] = "x axis";
                cols[1] = "5 unit epoch";
                cols[2] = "10 unit epoch";
                cols[3] = "20 unit epoch";
                cols[4] = "30 unit epoch";
                cols[5] = "40 unit epoch";
                cols[6] = "50 unit epoch";
            } else {
                cols[0] = vm.toString(i * 1e18);
                cols[1] = vm.toString(expToTarget(1e18, 0.9e18, i, 5));
                cols[2] = vm.toString(expToTarget(1e18, 0.9e18, i, 10));
                cols[3] = vm.toString(expToTarget(1e18, 0.9e18, i, 20));
                cols[4] = vm.toString(expToTarget(1e18, 0.9e18, i, 30));
                cols[5] = vm.toString(expToTarget(1e18, 0.9e18, i, 40));
                cols[6] = vm.toString(expToTarget(1e18, 0.9e18, i, 50));
            }


            writeRowToCSV("input.csv", cols);
        }

        // Create output svg with values denominated in wad
        plotWad("input.csv", "output.svg", 6);
    }
}
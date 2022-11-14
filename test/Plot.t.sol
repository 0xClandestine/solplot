// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Plot.sol";

contract DemoPlot is Plot {
    // Some math to plot out...
    function expToTarget(
        uint256 initialValue,
        uint256 targetValue,
        uint256 index,
        uint256 epochLength
    ) internal pure returns (uint256 output) {
        output = initialValue >> (index / epochLength);
        output -= (output * (index % epochLength) / epochLength) >> 1;
        output += (initialValue - output) * targetValue / initialValue;
    }

    function testPlot_ExpToTarget() public {
        vm.removeFile("input.csv");

        // Create input csv
        for (uint256 i; i < 100; i++) {
            // Use first row as legend
            if (i == 0) {
                // Make sure the same amount of columns are included for the legend
                vm.writeLine("input.csv", "x axis,h = 5,h = 10,h = 20,h = 30,h = 40,h = 50,");
            } else {
                uint256[] memory cols = new uint256[](7);

                cols[0] = i * 1e18;
                cols[1] = expToTarget(1e18, 0.9e18, i - 1, 5);
                cols[2] = expToTarget(1e18, 0.9e18, i - 1, 10);
                cols[3] = expToTarget(1e18, 0.9e18, i - 1, 20);
                cols[4] = expToTarget(1e18, 0.9e18, i - 1, 30);
                cols[5] = expToTarget(1e18, 0.9e18, i - 1, 40);
                cols[6] = expToTarget(1e18, 0.9e18, i - 1, 50);

                writeRowToCSV("input.csv", cols);
            }
        }

        // Create output svg with values denominated in wad
        plot({
            inputCsv: "input.csv",
            outputSvg: "output.svg",
            inputDecimals: 18,
            totalColumns: 6,
            legend: true
        });
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Plot} from "../src/Plot.sol";

// Some math to plot out...
function expToLevel(uint256 x, uint256 y, uint256 i, uint256 h)
    pure
    returns (uint256 z)
{
    z = x >> (i / h);
    z -= (z * (i % h) / h) >> 1;
    z += (x - z) * y / x;
}

contract DemoPlot is Plot {
    function testPlot() public {
        unchecked {
            string memory input = "input.csv";
            string memory output = "output.svg";
            string memory legend = ",h = 5,h = 10,h = 15,";

            uint256 base = 1 ether;
            uint256 target = 0.9 ether;
            uint256[] memory cols = new uint256[](4);

            // Remove previous demo input CSV if it exists locally
            try vm.removeFile(input) {} catch {}

            // Write legend on the first line of demo output CSV
            vm.writeLine(input, legend);

            // Loop over a range, and compute the results of the mathematical function
            for (uint256 i; i < 100; ++i) {
                cols[0] = i * 1e18;
                cols[1] = expToLevel(base, target, i, 5);
                cols[2] = expToLevel(base, target, i, 10);
                cols[3] = expToLevel(base, target, i, 15);

                // Append the results to the input CSV
                writeRowToCSV(input, cols);
            }

            // Once the input CSV is fully created, use it to plot the output SVG
            plot({
                inputCsv: input,
                outputSvg: output,
                inputDecimals: 18,
                totalColumns: 4,
                legend: true
            });
        }
    }
}

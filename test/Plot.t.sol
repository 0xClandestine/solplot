// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Plot.sol";

contract PlotTest is Plot {

    function testPlot() public {
        plot("input.txt", "output.svg");
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract Plot is Test {
    function plot(
        string memory inputFile,
        string memory outputFile,
        string memory plotColor,
        uint8 decimals
    ) public {

        string[] memory ffi = new string[](9);

        ffi[0] = "solplot";

        ffi[1] = "--input-file";

        ffi[2] = inputFile;

        ffi[3] = "--output-file";

        ffi[4] = outputFile;

        ffi[5] = "--plot-color";

        ffi[6] = plotColor;

        ffi[7] = "--decimals";

        ffi[8] = vm.toString(decimals);

        vm.ffi(ffi);
    }

    function plot(
        string memory inputFile,
        string memory outputFile,
        string memory plotColor
    ) public {
        plot(inputFile, outputFile, plotColor, 1);
    }

    function plotWad(
        string memory inputFile,
        string memory outputFile,
        string memory plotColor
    ) public {
        plot(inputFile, outputFile, plotColor, 18);
    }
}

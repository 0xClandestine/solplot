// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract Plot is Test {
    function plot(string memory inputFile, string memory outputFile, uint8 decimals, uint8 totalColumns) public {
        string[] memory ffi = new string[](9);

        ffi[0] = "solplot";

        ffi[1] = "--input-file";

        ffi[2] = inputFile;

        ffi[3] = "--output-file";

        ffi[4] = outputFile;

        ffi[5] = "--decimals";

        ffi[6] = vm.toString(decimals);

        ffi[7] = "--columns";

        ffi[8] = vm.toString(totalColumns);

        vm.ffi(ffi);
    }

    function plot(string memory inputFile, string memory outputFile, uint8 totalColumns) public {
        plot(inputFile, outputFile, 1, totalColumns);
    }

    function plotWad(string memory inputFile, string memory outputFile, uint8 totalColumns) public {
        plot(inputFile, outputFile, 18, totalColumns);
    }

    function writeToCSV(string memory file, string[] memory cols) public {
        string memory row;

        for (uint256 i; i < cols.length; i++) {
            if (i == 0) {
                row = string.concat(cols[i], ",");
            } else {
                row = string.concat(row, cols[i], ",");
            }
        }

        vm.writeLine(file, row);
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract Plot is Test {
    /// @notice Plot chart via plotly-rs + hevm ffi.
    /// @param inputCsv - Path to csv file that contains the plot data.
    /// @param outputSvg - Path to save svg output to.
    /// @param inputDecimals - Denomination of the input data.
    /// @param totalColumns - Total number of columns within inputCsv to plot.
    /// @param legend - Determines whether the first row of the inputCsv should be used for legend naming.
    function plot(
        string memory inputCsv,
        string memory outputSvg,
        uint8 inputDecimals,
        uint8 totalColumns,
        bool legend
    ) public {
        if (legend) {
            string[] memory ffi = new string[](10);

            ffi[0] = "solplot";

            ffi[1] = "--input-file";
            ffi[2] = inputCsv;

            ffi[3] = "--output-file";
            ffi[4] = outputSvg;

            ffi[5] = "--decimals";
            ffi[6] = vm.toString(inputDecimals);

            ffi[7] = "--columns";
            ffi[8] = vm.toString(totalColumns);

            ffi[9] = "--legend";

            vm.ffi(ffi);
        } else {
            string[] memory ffi = new string[](9);

            ffi[0] = "solplot";

            ffi[1] = "--input-file";
            ffi[2] = inputCsv;

            ffi[3] = "--output-file";
            ffi[4] = outputSvg;

            ffi[5] = "--decimals";
            ffi[6] = vm.toString(inputDecimals);

            ffi[7] = "--columns";
            ffi[8] = vm.toString(totalColumns);

            vm.ffi(ffi);
        }
    }

    function writeRowToCSV(string memory file, string[] memory cols) public {
        string memory row;

        uint256 length = cols.length;
        for (uint256 i; i < length;) {
            if (i == 0) {
                row = string.concat(cols[i], ",");
            } else {
                row = string.concat(row, cols[i], ",");
            }
            unchecked {
                i += 1;
            }
        }

        vm.writeLine(file, row);
    }

    function writeRowToCSV(string memory file, uint256[] memory cols) public {
        string memory row;

        uint256 length = cols.length;
        for (uint256 i; i < length;) {
            if (i == 0) {
                row = string.concat(vm.toString(cols[i]), ",");
            } else {
                row = string.concat(row, vm.toString(cols[i]), ",");
            }
            unchecked {
                i += 1;
            }
        }

        vm.writeLine(file, row);
    }


    function writeRowToCSV(string memory file, int256[] memory cols) public {
        string memory row;

        uint256 length = cols.length;
        for (uint256 i; i < length;) {
            if (i == 0) {
                row = string.concat(vm.toString(cols[i]), ",");
            } else {
                row = string.concat(row, vm.toString(cols[i]), ",");
            }
            unchecked {
                i += 1;
            }
        }

        vm.writeLine(file, row);
    }
}

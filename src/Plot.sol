// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

/// @title Plot contract for generating plots from CSV data
/// @dev This contract provides functions to generate plots and write rows to CSV files.
abstract contract Plot is Test {
    /// @notice Generates a plot from input CSV data and saves it as an SVG file
    /// @param inputCsv The input CSV data
    /// @param outputSvg The output SVG file name
    /// @param inputDecimals The number of decimals in the input data
    /// @param totalColumns The total number of columns in the CSV data
    /// @param legend A boolean indicating whether to include a legend in the plot
    function plot(
        string memory inputCsv,
        string memory outputSvg,
        uint8 inputDecimals,
        uint8 totalColumns,
        bool legend
    ) public {
        uint256 n;

        assembly {
            n := add(9, legend)
        }

        string[] memory ffi = new string[](n);

        ffi[0] = "solplot";

        ffi[1] = "--input-file";
        ffi[2] = inputCsv;

        ffi[3] = "--output-file";
        ffi[4] = outputSvg;

        ffi[5] = "--decimals";
        ffi[6] = vm.toString(inputDecimals);

        ffi[7] = "--columns";
        ffi[8] = vm.toString(totalColumns);

        if (legend) ffi[9] = "--legend";

        vm.ffi(ffi);
    }

    /// @notice Writes a row of string data to a CSV file
    /// @param file A string representing the CSV file that's written to
    /// @param cols An array of string values representing the columns in the row
    /// @return A string representing the CSV file that's written to
    function writeRowToCSV(string memory file, string[] memory cols)
        public
        returns (string memory)
    {
        unchecked {
            uint256 n = cols.length;

            string memory row = string.concat(cols[0], ",");

            for (uint256 i = 1; i < n; ++i) {
                row = string.concat(row, cols[i], ",");
            }

            vm.writeLine(file, row);

            return file;
        }
    }

    /// @notice Writes a row of uint256 data to a CSV file
    /// @param file A string representing the CSV file that's written to
    /// @param cols An array of uint256 values representing the columns in the row
    /// @return A string representing the CSV file that's written to
    function writeRowToCSV(string memory file, uint256[] memory cols)
        public
        returns (string memory)
    {
        unchecked {
            uint256 n = cols.length;

            string memory row = string.concat(vm.toString(cols[0]), ",");

            for (uint256 i = 1; i < n; ++i) {
                row = string.concat(row, vm.toString(cols[i]), ",");
            }

            vm.writeLine(file, row);

            return file;
        }
    }

    /// @notice Writes a row of int256 data to a CSV file
    /// @param file A string representing the CSV file that's written to
    /// @param cols An array of int256 values representing the columns in the row
    /// @return A string representing the CSV file that's written to
    function writeRowToCSV(string memory file, int256[] memory cols)
        public
        returns (string memory)
    {
        unchecked {
            uint256 n = cols.length;

            string memory row = string.concat(vm.toString(cols[0]), ",");

            for (uint256 i = 1; i < n; ++i) {
                row = string.concat(row, vm.toString(cols[i]), ",");
            }

            vm.writeLine(file, row);

            return file;
        }
    }
}

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

/// @title Plot contract for generating plots from CSV data
/// @dev This contract provides functions to generate plots and write rows to CSV files.
abstract contract Plot is Test {
    /// -----------------------------------------------------------------------
    /// Generates a plot from input CSV data and saves it as an image
    /// -----------------------------------------------------------------------

    function plot(
        string memory csv,
        string memory output,
        string memory title,
        uint256 precision,
        uint256 columns,
        uint256 width,
        uint256 height,
        bool legend
    ) internal virtual {
        uint256 n;

        assembly {
            n := add(15, legend)
        }

        string[] memory ffi = new string[](n);

        ffi[0] = "solplot";

        ffi[1] = "-i";
        ffi[2] = csv;

        ffi[3] = "-o";
        ffi[4] = output;

        ffi[5] = "-p";
        ffi[6] = vm.toString(precision);

        ffi[7] = "-c";
        ffi[8] = vm.toString(columns);

        ffi[9] = "-w";
        ffi[10] = vm.toString(width);

        ffi[11] = "-h";
        ffi[12] = vm.toString(height);

        ffi[13] = "-t";
        ffi[14] = title;

        if (legend) ffi[15] = "-l";

        vm.ffi(ffi);
    }

    /// -----------------------------------------------------------------------
    ///  Writes a row of string data to a CSV file
    /// -----------------------------------------------------------------------

    function writeRowToCSV(string memory file, string[] memory cols)
        internal
        virtual
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

    function writeRowToCSV(string memory file, string memory column0)
        internal
        virtual
        returns (string memory)
    {
        vm.writeLine(file, string.concat(column0, ","));

        return file;
    }

    function writeRowToCSV(string memory file, string memory column0, string memory column1)
        internal
        virtual
        returns (string memory)
    {
        vm.writeLine(file, string.concat(column0, ",", column1, ","));

        return file;
    }

    function writeRowToCSV(
        string memory file,
        string memory column0,
        string memory column1,
        string memory column2
    ) internal virtual returns (string memory) {
        vm.writeLine(file, string.concat(column0, ",", column1, ",", column2, ","));

        return file;
    }

    function writeRowToCSV(
        string memory file,
        string memory column0,
        string memory column1,
        string memory column2,
        string memory column3
    ) internal virtual returns (string memory) {
        vm.writeLine(file, string.concat(column0, ",", column1, ",", column2, ",", column3, ","));

        return file;
    }

    function writeRowToCSV(
        string memory file,
        string memory column0,
        string memory column1,
        string memory column2,
        string memory column3,
        string memory column4
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(column0, ",", column1, ",", column2, ",", column3, ",", column4, ",")
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        string memory column0,
        string memory column1,
        string memory column2,
        string memory column3,
        string memory column4,
        string memory column5
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                column0, ",", column1, ",", column2, ",", column3, ",", column4, ",", column5, ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        string memory column0,
        string memory column1,
        string memory column2,
        string memory column3,
        string memory column4,
        string memory column5,
        string memory column6
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                column0,
                ",",
                column1,
                ",",
                column2,
                ",",
                column3,
                ",",
                column4,
                ",",
                column5,
                ",",
                column6,
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        string memory column0,
        string memory column1,
        string memory column2,
        string memory column3,
        string memory column4,
        string memory column5,
        string memory column6,
        string memory column7
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                column0,
                ",",
                column1,
                ",",
                column2,
                ",",
                column3,
                ",",
                column4,
                ",",
                column5,
                ",",
                column6,
                ",",
                column7,
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        string memory column0,
        string memory column1,
        string memory column2,
        string memory column3,
        string memory column4,
        string memory column5,
        string memory column6,
        string memory column7,
        string memory column8
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                column0,
                ",",
                column1,
                ",",
                column2,
                ",",
                column3,
                ",",
                column4,
                ",",
                column5,
                ",",
                column6,
                ",",
                column7,
                ",",
                column8,
                ","
            )
        );

        return file;
    }

    /// -----------------------------------------------------------------------
    /// Writes a row of uint256 data to a CSV file
    /// -----------------------------------------------------------------------

    function writeRowToCSV(string memory file, uint256[] memory cols)
        internal
        virtual
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

    function writeRowToCSV(string memory file, uint256 column0)
        internal
        virtual
        returns (string memory)
    {
        vm.writeLine(file, string.concat(vm.toString(column0), ","));

        return file;
    }

    function writeRowToCSV(string memory file, uint256 column0, uint256 column1)
        internal
        virtual
        returns (string memory)
    {
        vm.writeLine(file, string.concat(vm.toString(column0), ",", vm.toString(column1), ","));

        return file;
    }

    function writeRowToCSV(string memory file, uint256 column0, uint256 column1, uint256 column2)
        internal
        virtual
        returns (string memory)
    {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0), ",", vm.toString(column1), ",", vm.toString(column2), ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        uint256 column0,
        uint256 column1,
        uint256 column2,
        uint256 column3
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        uint256 column0,
        uint256 column1,
        uint256 column2,
        uint256 column3,
        uint256 column4
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        uint256 column0,
        uint256 column1,
        uint256 column2,
        uint256 column3,
        uint256 column4,
        uint256 column5
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ",",
                vm.toString(column5),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        uint256 column0,
        uint256 column1,
        uint256 column2,
        uint256 column3,
        uint256 column4,
        uint256 column5,
        uint256 column6
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ",",
                vm.toString(column5),
                ",",
                vm.toString(column6),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        uint256 column0,
        uint256 column1,
        uint256 column2,
        uint256 column3,
        uint256 column4,
        uint256 column5,
        uint256 column6,
        uint256 column7
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ",",
                vm.toString(column5),
                ",",
                vm.toString(column6),
                ",",
                vm.toString(column7),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        uint256 column0,
        uint256 column1,
        uint256 column2,
        uint256 column3,
        uint256 column4,
        uint256 column5,
        uint256 column6,
        uint256 column7,
        uint256 column8
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ",",
                vm.toString(column5),
                ",",
                vm.toString(column6),
                ",",
                vm.toString(column7),
                ",",
                vm.toString(column8),
                ","
            )
        );

        return file;
    }

    /// -----------------------------------------------------------------------
    /// Writes a row of int256 data to a CSV file
    /// -----------------------------------------------------------------------

    function writeRowToCSV(string memory file, int256[] memory cols)
        internal
        virtual
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

    function writeRowToCSV(string memory file, int256 column0)
        internal
        virtual
        returns (string memory)
    {
        vm.writeLine(file, string.concat(vm.toString(column0), ","));

        return file;
    }

    function writeRowToCSV(string memory file, int256 column0, int256 column1)
        internal
        virtual
        returns (string memory)
    {
        vm.writeLine(file, string.concat(vm.toString(column0), ",", vm.toString(column1), ","));

        return file;
    }

    function writeRowToCSV(string memory file, int256 column0, int256 column1, int256 column2)
        internal
        virtual
        returns (string memory)
    {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0), ",", vm.toString(column1), ",", vm.toString(column2), ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        int256 column0,
        int256 column1,
        int256 column2,
        int256 column3
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        int256 column0,
        int256 column1,
        int256 column2,
        int256 column3,
        int256 column4
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        int256 column0,
        int256 column1,
        int256 column2,
        int256 column3,
        int256 column4,
        int256 column5
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ",",
                vm.toString(column5),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        int256 column0,
        int256 column1,
        int256 column2,
        int256 column3,
        int256 column4,
        int256 column5,
        int256 column6
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ",",
                vm.toString(column5),
                ",",
                vm.toString(column6),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        int256 column0,
        int256 column1,
        int256 column2,
        int256 column3,
        int256 column4,
        int256 column5,
        int256 column6,
        int256 column7
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ",",
                vm.toString(column5),
                ",",
                vm.toString(column6),
                ",",
                vm.toString(column7),
                ","
            )
        );

        return file;
    }

    function writeRowToCSV(
        string memory file,
        int256 column0,
        int256 column1,
        int256 column2,
        int256 column3,
        int256 column4,
        int256 column5,
        int256 column6,
        int256 column7,
        int256 column8
    ) internal virtual returns (string memory) {
        vm.writeLine(
            file,
            string.concat(
                vm.toString(column0),
                ",",
                vm.toString(column1),
                ",",
                vm.toString(column2),
                ",",
                vm.toString(column3),
                ",",
                vm.toString(column4),
                ",",
                vm.toString(column5),
                ",",
                vm.toString(column6),
                ",",
                vm.toString(column7),
                ",",
                vm.toString(column8),
                ","
            )
        );

        return file;
    }
}

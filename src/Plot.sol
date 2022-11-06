// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

abstract contract Plot is Test {
    
    function plot(string memory inputFile, string memory outputFile) public {
        
        string[] memory ffi = new string[](5);

        ffi[0] = "solplot";

        ffi[1] = "--input-file";
    
        ffi[2] = inputFile;

        ffi[3] = "--output-file";

        ffi[4] = outputFile;

        vm.ffi(ffi);
    }
}
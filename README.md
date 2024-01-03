# 🖌️solplot
A Foundry plugin that enables you to plot charts within solidity.

![output](output.svg)


&nbsp;
# Installation
First, make sure that you have [Rust installed](https://www.rust-lang.org/tools/install). Then install source as directed below.

<!-- &nbsp;
### Install from crates.io
```
cargo install solplot
``` -->

&nbsp;
### Installing binary from source
```
git clone https://github.com/0xClandestine/solplot &&
cd solplot &&
cargo install --path .
```

Then add `solplot` to your foundry project.

```
forge install 0xClandestine/solplot
```

Now simply inherit `Plot` into your test contract, and you'll have access to plotting methods.

```js
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

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
```

&nbsp;
# Usage


```
Usage: solplot [OPTIONS] --input-file <INPUT_FILE> --output-file <OUTPUT_FILE> --decimals <DECIMALS> --columns <COLUMNS>

Options:
  -i, --input-file <INPUT_FILE>    
  -o, --output-file <OUTPUT_FILE>  
      --decimals <DECIMALS>        
      --columns <COLUMNS>
      --legend
  -h, --help                       Print help information
  -V, --version                    Print version information
```
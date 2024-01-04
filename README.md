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

import {Plot} from "solplot/src/Plot.sol";

// Some math to plot out...
function expToLevel(uint256 x, uint256 y, uint256 i, uint256 h) pure returns (uint256 z) {
    z = x >> (i / h);
    z -= (z * (i % h) / h) >> 1;
    z += (x - z) * y / x;
}

contract DemoPlot is Plot {
    function testPlot() public {
        unchecked {
            // Remove previous demo input CSV if it exists locally
            try vm.removeFile("input.csv") {} catch {}

            // Write legend on the first line of demo output CSV
            // NOTE: Use the 'writeRowToCSV(string memory, string[] memory)'
            //       if more than 9 columns are needed.
            writeRowToCSV(
                "input.csv", "x-axis", "h=5", "h=10", "h=15", "h=20", "h=25", "h=30", "h=35", "h=40"
            );

            // Loop over a range, and compute the results of some math
            for (uint256 i; i < 150; ++i) {
                // NOTE: Use the 'writeRowToCSV(string memory, uint256[] memory)'
                //       if more than 9 columns are needed.
                writeRowToCSV(
                    "input.csv",
                    i * 1 ether,
                    expToLevel(1 ether, 0.9 ether, i, 5),
                    expToLevel(1 ether, 0.9 ether, i, 10),
                    expToLevel(1 ether, 0.9 ether, i, 15),
                    expToLevel(1 ether, 0.9 ether, i, 20),
                    expToLevel(1 ether, 0.9 ether, i, 25),
                    expToLevel(1 ether, 0.9 ether, i, 30),
                    expToLevel(1 ether, 0.9 ether, i, 35),
                    expToLevel(1 ether, 0.9 ether, i, 40)
                );
            }

            // Once the input CSV is fully created, use it to plot the output SVG
            // NOTE: Output file can be .png or .svg
            plot("input.csv", "output.svg", "ExpToLevel(x, y, i, h) -> (z) Plot", 18, 9, 900, 600, true);
        }
    }
}
```

&nbsp;
# Usage

```
Usage: solplot [OPTIONS] --input-file <INPUT_FILE> --output-file <OUTPUT_FILE> --precision <PRECISION> --columns <COLUMNS>

Options:
  -i, --input-file <INPUT_FILE>
  -o, --output-file <OUTPUT_FILE>
  -p, --precision <PRECISION>
  -c, --columns <COLUMNS>
  -w, --width <WIDTH>              [default: 800]
  -h, --height <HEIGHT>            [default: 600]
  -t, --title <TITLE>
  -l, --legend
  -h, --help                       Print help
```
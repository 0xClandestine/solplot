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

Now simply inherit `Plot` into your test contract, and you'll have access to `plot(<input_file>, <output_file>, <plot_color>)`.

```js
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solplot/Plot.sol";

contract PlotTest is Plot {

    function testPlot() public {
        plot("input.txt", "output.svg", "cyan", 18);
    }
}

```

&nbsp;
# Usage


```
Usage: solplot [OPTIONS]

Options:
-i, --input-file <INPUT_FILE>
-o, --output-file <OUTPUT_FILE>
--plot-color <PLOT_COLOR>
--decimals <DECIMALS>

Usage: solplot --input-file <INPUT_FILE> --output-file <OUTPUT_FILE> --plot-color <PLOT_COLOR>
```
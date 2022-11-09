use clap::Parser;

mod lib;

fn main() {
    lib::Chart::parse().plot();
}

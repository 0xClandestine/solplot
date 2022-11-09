use clap::Parser;

mod lib;

fn main() {
    lib::Chart::plot(&lib::Chart::parse());
}

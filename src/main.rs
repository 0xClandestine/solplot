use clap::Parser;

mod lib;

fn main() {
    let chart = lib::Chart::save(&lib::Chart::parse());
}

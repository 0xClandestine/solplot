use clap::Parser;

mod lib;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    #[arg(short, long, required = true)]
    input_file: String,

    #[arg(short, long, required = true)]
    output_file: String,

    #[arg(long, required = true)]
    plot_color: String,
}

fn main() {
    let args = Args::parse();

    lib::to_chart(
        args.input_file,
        args.output_file,
        args.plot_color
    );
}

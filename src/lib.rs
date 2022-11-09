use plotly::{common::Mode, ImageFormat, Plot, Scatter};

use clap::Parser;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
pub struct Chart {
    #[arg(short, long, required = true)]
    pub input_file: String,

    #[arg(short, long, required = true)]
    pub output_file: String,

    #[arg(long, required = true)]
    pub plot_color: String,

    #[arg(long, required = true)]
    pub decimals: u32,
}

impl Chart {

    pub fn save(&self) {
        let data = txt_writer::ReadData {}
            .read(&self.input_file)
            .expect("Error reading file...");
    
        let mut x_axis = vec![];
        let mut y_axis = vec![];
    
        for (i, y) in data.iter().enumerate() {
            let denominator = if self.decimals == 1 {
                1.0
            } else {
                10.0_f64.powf(self.decimals.into())
            };
    
            x_axis.push(i as f64);
            y_axis.push(y.parse::<f64>().unwrap() / denominator);
        }
    
        let mut plot = Plot::new();
    
        plot.add_trace(
            Scatter::new(x_axis, y_axis)
                .mode(Mode::Lines)
                .name("Lines"),
        );
    
        plot.write_image(&self.output_file, ImageFormat::SVG, 800, 600, 1.0);
    }
}
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
    pub decimals: f64,

    #[arg(long, required = true)]
    pub columns: usize,
}

pub struct Column {
    pub name: String,
    pub contents: Vec<f64>,
}

impl Chart {

    pub fn parse_column(&self, n: usize) -> Column {
        let mut values = vec![];

        let denominator = if self.decimals == 1.0 {
            1.0
        } else {
            10.0_f64.powf(self.decimals.into())
        };

        let data = txt_writer::ReadData {}
            .read_one(&self.input_file)
            .expect("Error reading file...");

        let csv = quick_csv::Csv::from_string(&data);

        let mut column_name = "".to_string();

        for (i, row) in csv.into_iter().enumerate() {
            if let Ok(r) = row {

                let mut cols = r.columns().expect("Error converting column...");
                let col = cols.nth(n).unwrap().parse::<String>().unwrap();

                // We assume the first row is used to name columns
                if i != 0 {
                    values.push(col.parse::<f64>().unwrap() / denominator);
                } else {
                    column_name = col;
                }
            }
        }

        Column{name: column_name, contents: values}
    }

    pub fn plot(&self) {
        let mut plot = Plot::new();

        let x_axis = self.parse_column(0).contents;

        // First column is always `x` axis, each additional column is a plot
        for i in 1..self.columns {

            let column: Column = self.parse_column(i);

            plot.add_trace(
                Scatter::new(x_axis.clone(), column.contents)
                    .mode(Mode::Lines)
                    .name(column.name),
            );
        }

        plot.write_image(&self.output_file, ImageFormat::SVG, 800, 600, 1.0);
    }
}

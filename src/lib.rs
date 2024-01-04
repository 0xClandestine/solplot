use clap::Parser;
use plotly::{common::Mode, common::Title, Layout, ImageFormat, Plot, Scatter};
use std::path::Path;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
pub struct Chart {
    #[arg(short, long, required = true)]
    pub input_file: String,

    #[arg(short, long, required = true)]
    pub output_file: String,

    #[arg(short, long, required = true)]
    pub precision: f64,

    #[arg(short, long, required = true)]
    pub columns: usize,

    #[arg(short, long, required = false, default_value = "800")]
    pub width: usize,

    #[arg(short, long, required = false, default_value = "600")]
    pub height: usize,

    #[arg(short, long, required = false)]
    pub title: String,

    #[arg(short, long, required = false)]
    pub legend: bool,
}

pub struct Column {
    pub name: String,
    pub contents: Vec<f64>,
}

impl Chart {
    pub fn parse_column(&self, n: usize) -> Column {
        let mut values = vec![];

        let denominator = if self.precision == 1.0 {
            1.0
        } else {
            10.0_f64.powf(self.precision.into())
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

                // We assume the first row is used to name columns if legend is true
                if self.legend {
                    if i != 0 {
                        values.push(col.parse::<f64>().unwrap() / denominator);
                    } else {
                        column_name = col;
                    }
                } else {
                    values.push(col.parse::<f64>().unwrap() / denominator);
                }
            }
        }

        Column {
            name: column_name,
            contents: values,
        }
    }

    pub fn plot(&self) {
        let mut plot = Plot::new();

        let x_axis = self.parse_column(0).contents;

        for i in 1..self.columns {
            let column: Column = self.parse_column(i);

            plot.add_trace(
                Scatter::new(x_axis.clone(), column.contents)
                    .mode(Mode::Lines)
                    .name(column.name),
            );
        }

        let image_format = match Path::new(&self.output_file).extension() {
            Some(ext) if ext == "svg" => ImageFormat::SVG,
            Some(ext) if ext == "png" => ImageFormat::PNG,
            _ => {
                eprintln!("Unsupported file format. Defaulting to SVG.");
                ImageFormat::SVG
            }
        };

        if !self.title.is_empty() {
            plot.set_layout(Layout::new().title(Title::new(&self.title)));
        }

        plot.write_image(
            &self.output_file,
            image_format,
            self.width,
            self.height,
            1.0,
        );
    }
}

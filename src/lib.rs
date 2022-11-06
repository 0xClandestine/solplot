use plotlib::page::Page;
use plotlib::repr::Plot;
use plotlib::style::{LineJoin, LineStyle};
use plotlib::view::ContinuousView;
use txt_writer::ReadData;

pub fn to_num(string: String) -> i128 {
    string.parse::<i128>().unwrap() as i128
}

pub fn to_vec(input_file: String) -> Vec<(f64, f64)> {
    let data = ReadData {}.read(input_file).expect("Error reading file...");

    let mut coordinates = vec![];
    let mut line_count: i128 = 0;

    for x in data {
        coordinates.push((line_count as f64, (to_num(x) as f64) / 1e18 as f64));
        line_count += 1;
    }

    coordinates
}

pub fn to_chart(input_file: String, output_file: String) {

    let chart = Plot::new(to_vec(input_file))
        .line_style(
            LineStyle::new()
                .colour("cyan")
                .linejoin(LineJoin::Round),
        );

    let view = ContinuousView::new()
        .add(chart);

    Page::single(&view)
        .save(output_file)
        .expect("Error saving chart...");
}
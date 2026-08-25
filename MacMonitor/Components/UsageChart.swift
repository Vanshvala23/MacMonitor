import SwiftUI
import Charts

struct UsageChart: View {

    let samples: [MetricSample]
    let title: String
    let unit: String
    let maximum: Double

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {

                Text(title)
                    .font(.headline)

                Spacer()

                if let latest = samples.last {

                    Text(
                        String(
                            format: "%.0f%@",
                            latest.value,
                            unit
                        )
                    )
                    .font(.headline)
                    .monospacedDigit()
                }
            }

            Chart(samples) { sample in

                AreaMark(
                    x: .value(
                        "Time",
                        sample.timestamps
                    ),
                    y: .value(
                        "Value",
                        sample.value
                    )
                )
                .opacity(0.15)

                LineMark(
                    x: .value(
                        "Time",
                        sample.timestamps
                    ),
                    y: .value(
                        "Value",
                        sample.value
                    )
                )
                .lineStyle(
                    StrokeStyle(
                        lineWidth: 2,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
            }
            .chartYScale(domain: 0...maximum)
            .chartXAxis(.hidden)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 180)
        }
        .padding(24)
        .background(
            .regularMaterial,
            in: RoundedRectangle(
                cornerRadius: 18
            )
        )
    }
}

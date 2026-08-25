import SwiftUI

struct CPUView: View {

    @StateObject private var viewModel = CPUViewModel()

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 28) {

                // MARK: - Header

                VStack(alignment: .leading, spacing: 6) {

                    Text("CPU")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Monitor processor usage in real time.")
                        .foregroundStyle(.secondary)
                }

                // MARK: - Current Usage

                HStack(spacing: 18) {

                    Image(systemName: "cpu")
                        .font(.system(size: 28))

                    VStack(alignment: .leading, spacing: 4) {

                        Text("CPU Usage")
                            .font(.headline)

                        Text("\(Int(viewModel.usage))%")
                            .font(
                                .system(
                                    size: 42,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .monospacedDigit()
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {

                        Text("Status")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text(cpuStatus)
                            .font(.headline)
                    }
                }
                .padding(24)
                .background(
                    .regularMaterial,
                    in: RoundedRectangle(
                        cornerRadius: 18
                    )
                )

                // MARK: - CPU Graph

                UsageChart(
                    samples: viewModel.history,
                    title: "CPU Usage",
                    unit: "%",
                    maximum: 100
                )
                // MARK: - CPU Cores

                VStack(alignment: .leading, spacing: 14) {

                    Text("CPU Cores")
                        .font(.title2)
                        .fontWeight(.semibold)

                    LazyVGrid(
                        columns: [
                            GridItem(.adaptive(minimum: 140))
                        ],
                        spacing: 14
                    ) {

                        ForEach(
                            viewModel.coreUsages.indices,
                            id: \.self
                        ) { index in

                            let usage =
                                viewModel.coreUsages[index]

                            VStack(
                                alignment: .leading,
                                spacing: 10
                            ) {

                                HStack {

                                    Image(systemName: "cpu")

                                    Text("Core \(index + 1)")
                                        .fontWeight(.medium)

                                    Spacer()

                                    Text("\(Int(usage))%")
                                        .fontWeight(.bold)
                                        .monospacedDigit()
                                }

                                ProgressView(
                                    value: usage,
                                    total: 100
                                )
                            }
                            .padding(16)
                            .background(
                                .regularMaterial,
                                in: RoundedRectangle(
                                    cornerRadius: 14
                                )
                            )
                        }
                    }
                }

                // MARK: - Information

                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 18
                ) {

                    StatCard(
                        title: "Current",
                        value: "\(Int(viewModel.usage))%",
                        subtitle: "Current CPU usage",
                        systemImage: "gauge.medium"
                    )

                    StatCard(
                        title: "Samples",
                        value: "\(viewModel.history.count)",
                        subtitle: "Last 60 seconds",
                        systemImage: "chart.xyaxis.line"
                    )
                }
            }
            .padding(32)
        }
    }

    // MARK: - CPU Status

    private var cpuStatus: String {

        switch viewModel.usage {

        case 0..<30:
            return "Low"

        case 30..<70:
            return "Normal"

        case 70..<90:
            return "High"

        default:
            return "Very High"
        }
    }
}

#Preview {
    CPUView()
        .frame(
            width: 1000,
            height: 650
        )
}

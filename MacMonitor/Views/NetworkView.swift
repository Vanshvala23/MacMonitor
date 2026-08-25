//
//  NetworkView.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import SwiftUI

struct NetworkView: View {

    @StateObject private var viewModel = NetworkViewModel()

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 28) {

                // MARK: - Header

                VStack(alignment: .leading, spacing: 6) {

                    Text("Network")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Monitor network activity in real time.")
                        .foregroundStyle(.secondary)
                }

                // MARK: - Current Network Activity

                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 18
                ) {

                    StatCard(
                        title: "Download",
                        value: formatSpeed(
                            viewModel.downloadSpeed
                        ),
                        subtitle: "Current download speed",
                        systemImage: "arrow.down.circle"
                    )

                    StatCard(
                        title: "Upload",
                        value: formatSpeed(
                            viewModel.uploadSpeed
                        ),
                        subtitle: "Current upload speed",
                        systemImage: "arrow.up.circle"
                    )
                }

                // MARK: - Download Chart

                UsageChart(
                    samples: viewModel.downloadHistory,
                    title: "Download Speed",
                    unit: "B/s",
                    maximum: chartMaximum(
                        viewModel.downloadHistory
                    )
                )

                // MARK: - Upload Chart

                UsageChart(
                    samples: viewModel.uploadHistory,
                    title: "Upload Speed",
                    unit: "B/s",
                    maximum: chartMaximum(
                        viewModel.uploadHistory
                    )
                )

                // MARK: - Totals

                VStack(alignment: .leading, spacing: 14) {

                    Text("Data Transfer")
                        .font(.title2)
                        .fontWeight(.semibold)

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 18
                    ) {

                        StatCard(
                            title: "Downloaded",
                            value: formatBytes(
                                viewModel.totalDownloaded
                            ),
                            subtitle: "Total received",
                            systemImage: "arrow.down.circle.fill"
                        )

                        StatCard(
                            title: "Uploaded",
                            value: formatBytes(
                                viewModel.totalUploaded
                            ),
                            subtitle: "Total sent",
                            systemImage: "arrow.up.circle.fill"
                        )
                    }
                }
            }
            .padding(32)
        }
    }

    // MARK: - Speed Formatting

    private func formatSpeed(
        _ bytes: UInt64
    ) -> String {

        let megabytes =
            Double(bytes) / 1_048_576.0

        if megabytes >= 1 {

            return String(
                format: "%.1f MB/s",
                megabytes
            )
        }

        let kilobytes =
            Double(bytes) / 1_024.0

        if kilobytes >= 1 {

            return String(
                format: "%.0f KB/s",
                kilobytes
            )
        }

        return "\(bytes) B/s"
    }

    // MARK: - Bytes Formatting

    private func formatBytes(
        _ bytes: UInt64
    ) -> String {

        let gigabytes =
            Double(bytes) / 1_073_741_824.0

        if gigabytes >= 1 {

            return String(
                format: "%.2f GB",
                gigabytes
            )
        }

        let megabytes =
            Double(bytes) / 1_048_576.0

        if megabytes >= 1 {

            return String(
                format: "%.1f MB",
                megabytes
            )
        }

        let kilobytes =
            Double(bytes) / 1_024.0

        return String(
            format: "%.0f KB",
            kilobytes
        )
    }

    // MARK: - Chart Maximum

    private func chartMaximum(
        _ samples: [MetricSample]
    ) -> Double {

        let highest =
            samples.map(\.value).max() ?? 0

        // Give the chart some breathing room.

        if highest <= 0 {
            return 1
        }

        return highest * 1.2
    }
}

#Preview {

    NetworkView()
        .frame(
            width: 1000,
            height: 650
        )
}
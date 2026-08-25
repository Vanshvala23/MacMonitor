//
//  MemoryView.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import SwiftUI

struct MemoryView: View {

    @StateObject private var viewModel = MemoryViewModel()

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 28) {

                // MARK: - Header

                VStack(alignment: .leading, spacing: 6) {

                    Text("Memory")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Monitor your Mac's memory usage in real time.")
                        .foregroundStyle(.secondary)
                }

                // MARK: - Memory Overview

                HStack(spacing: 18) {

                    Image(systemName: "memorychip")
                        .font(.system(size: 28))

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Memory Used")
                            .font(.headline)

                        Text(
                            formatBytes(viewModel.used)
                        )
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

                        Text("Usage")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text(
                            "\(Int(viewModel.usagePercentage))%"
                        )
                        .font(.headline)
                        .monospacedDigit()
                    }
                }
                .padding(24)
                .background(
                    .regularMaterial,
                    in: RoundedRectangle(
                        cornerRadius: 18
                    )
                )

                // MARK: - Memory Chart

                UsageChart(
                    samples: viewModel.history,
                    title: "Memory Usage",
                    unit: "%",
                    maximum: 100
                )

                // MARK: - Memory Information

                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 18
                ) {

                    StatCard(
                        title: "Used",
                        value: formatBytes(
                            viewModel.used
                        ),
                        subtitle: "Currently in use",
                        systemImage: "memorychip"
                    )

                    StatCard(
                        title: "Available",
                        value: formatBytes(
                            viewModel.available
                        ),
                        subtitle: "Available memory",
                        systemImage: "checkmark.circle"
                    )

                    StatCard(
                        title: "Total",
                        value: formatBytes(
                            viewModel.total
                        ),
                        subtitle: "Physical memory",
                        systemImage: "rectangle.3.group"
                    )

                    StatCard(
                        title: "Usage",
                        value: "\(Int(viewModel.usagePercentage))%",
                        subtitle: "Current memory pressure",
                        systemImage: "gauge.medium"
                    )
                }
            }
            .padding(32)
        }
    }

    // MARK: - Formatting

    private func formatBytes(
        _ bytes: UInt64
    ) -> String {

        let gigabytes =
            Double(bytes) / 1_073_741_824.0

        if gigabytes >= 1 {
            return String(
                format: "%.1f GB",
                gigabytes
            )
        }

        let megabytes =
            Double(bytes) / 1_048_576.0

        return String(
            format: "%.0f MB",
            megabytes
        )
    }
}

#Preview {
    MemoryView()
        .frame(
            width: 1000,
            height: 650
        )
}
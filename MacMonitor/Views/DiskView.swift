//
//  DiskView.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import SwiftUI

struct DiskView: View {

    @StateObject private var viewModel = DiskViewModel()

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 28) {

                // MARK: - Header

                VStack(alignment: .leading, spacing: 6) {

                    Text("Disk")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Monitor your Mac's storage.")
                        .foregroundStyle(.secondary)
                }

                // MARK: - Storage Overview

                VStack(spacing: 20) {

                    HStack {

                        Image(systemName: "internaldrive")
                            .font(.system(size: 28))

                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {

                            Text("Storage Used")
                                .font(.headline)

                            Text(
                                formatBytes(viewModel.used)
                            )
                            .font(
                                .system(
                                    size: 36,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .monospacedDigit()
                        }

                        Spacer()

                        VStack(
                            alignment: .trailing,
                            spacing: 4
                        ) {

                            Text("Usage")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(
                                "\(Int(viewModel.usagePercentage))%"
                            )
                            .font(.title2)
                            .fontWeight(.bold)
                            .monospacedDigit()
                        }
                    }

                    ProgressView(
                        value: viewModel.usagePercentage,
                        total: 100
                    )
                    .controlSize(.large)
                }
                .padding(24)
                .background(
                    .regularMaterial,
                    in: RoundedRectangle(
                        cornerRadius: 18
                    )
                )

                // MARK: - Storage Information

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
                        subtitle: "Storage in use",
                        systemImage: "internaldrive.fill"
                    )

                    StatCard(
                        title: "Available",
                        value: formatBytes(
                            viewModel.available
                        ),
                        subtitle: "Free storage",
                        systemImage: "externaldrive"
                    )

                    StatCard(
                        title: "Total",
                        value: formatBytes(
                            viewModel.total
                        ),
                        subtitle: "Total capacity",
                        systemImage: "internaldrive"
                    )

                    StatCard(
                        title: "Usage",
                        value: "\(Int(viewModel.usagePercentage))%",
                        subtitle: "Disk utilization",
                        systemImage: "chart.pie"
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
    DiskView()
        .frame(
            width: 1000,
            height: 650
        )
}
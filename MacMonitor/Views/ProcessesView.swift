//
//  ProcessesView.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import SwiftUI

struct ProcessesView: View {

    @StateObject private var viewModel =
        ProcessViewModel()

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            // MARK: - Header

            VStack(alignment: .leading, spacing: 6) {

                Text("Processes")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(
                    "\(viewModel.processes.count) processes running"
                )
                .foregroundStyle(.secondary)
            }

            // MARK: - Search

            TextField(
                "Search processes",
                text: $viewModel.searchText
            )
            .textFieldStyle(.roundedBorder)

            // MARK: - Process Table

            Table(
                viewModel.filteredProcesses
            ) {

                TableColumn("Process") { process in

                    HStack(spacing: 8) {

                        Image(
                            systemName: "gearshape"
                        )
                        .foregroundStyle(.secondary)

                        Text(process.name)
                            .lineLimit(1)
                    }
                }

                TableColumn("PID") { process in

                    Text("\(process.id)")
                        .monospacedDigit()
                }

                TableColumn("CPU") { process in

                    Text(
                        String(
                            format: "%.1f%%",
                            process.cpuUsage
                        )
                    )
                    .monospacedDigit()
                }

                TableColumn("Memory") { process in

                    Text(
                        formatBytes(
                            process.memoryUsage
                        )
                    )
                    .monospacedDigit()
                }
            }
        }
        .padding(32)
    }

    // MARK: - Formatting

    private func formatBytes(
        _ bytes: UInt64
    ) -> String {

        let megabytes =
            Double(bytes) / 1_048_576.0

        if megabytes >= 1024 {

            return String(
                format: "%.1f GB",
                megabytes / 1024
            )
        }

        return String(
            format: "%.0f MB",
            megabytes
        )
    }
}

#Preview {

    ProcessesView()
        .frame(
            width: 1000,
            height: 650
        )
}
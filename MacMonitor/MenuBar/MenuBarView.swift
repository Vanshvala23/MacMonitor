import SwiftUI

struct MenuBarView: View {

    @StateObject private var viewModel =
        MenuBarViewModel()

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            // MARK: - Header

            HStack(spacing: 10) {

                Image(
                    systemName:
                        "gauge.with.dots.needle.bottom.50percent"
                )
                .font(.title2)

                VStack(alignment: .leading, spacing: 2) {

                    Text("MacMonitor")
                        .font(.headline)

                    Text("System Status")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }

            Divider()

            // MARK: - CPU

            metricRow(
                title: "CPU",
                value: String(
                    format: "%.0f%%",
                    viewModel.cpuUsage
                ),
                icon: "cpu"
            )

            ProgressView(
                value: viewModel.cpuUsage,
                total: 100
            )

            // MARK: - Memory

            metricRow(
                title: "Memory",
                value:
                    "\(formatBytes(viewModel.memoryUsed)) / " +
                    "\(formatBytes(viewModel.memoryTotal))",
                icon: "memorychip"
            )

            ProgressView(
                value:
                    viewModel.memoryUsagePercentage,
                total: 100
            )

            // MARK: - Disk

            metricRow(
                title: "Disk",
                value:
                    "\(formatBytes(viewModel.diskAvailable)) free",
                icon: "internaldrive"
            )

            ProgressView(
                value:
                    viewModel.diskUsagePercentage,
                total: 100
            )

            // MARK: - Network

            VStack(alignment: .leading, spacing: 8) {

                HStack {

                    Image(systemName: "network")
                        .frame(width: 20)

                    Text("Network")
                        .font(.subheadline)

                    Spacer()
                }

                HStack {

                    Label(
                        formatSpeed(
                            viewModel.downloadSpeed
                        ),
                        systemImage: "arrow.down"
                    )

                    Spacer()

                    Label(
                        formatSpeed(
                            viewModel.uploadSpeed
                        ),
                        systemImage: "arrow.up"
                    )
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Divider()

            // MARK: - Actions

            Button {
                openMainWindow()
            } label: {

                Label(
                    "Open MacMonitor",
                    systemImage: "macwindow"
                )
            }
            .buttonStyle(.plain)

            Button {

                NSApplication.shared.terminate(nil)

            } label: {

                Label(
                    "Quit MacMonitor",
                    systemImage: "power"
                )
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .frame(width: 320)
    }

    // MARK: - Metric Row

    private func metricRow(
        title: String,
        value: String,
        icon: String
    ) -> some View {

        HStack {

            Image(systemName: icon)
                .frame(width: 20)

            Text(title)
                .font(.subheadline)

            Spacer()

            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .monospacedDigit()
        }
    }

    // MARK: - Bytes

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

        if megabytes >= 1 {

            return String(
                format: "%.0f MB",
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

    // MARK: - Network Speed

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

    // MARK: - Main Window

    private func openMainWindow() {

        NSApplication.shared.activate(
            ignoringOtherApps: true
        )

        NSApplication.shared.windows
            .first?
            .makeKeyAndOrderFront(nil)
    }
}

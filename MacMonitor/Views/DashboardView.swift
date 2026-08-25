import SwiftUI

struct DashboardView: View {

    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 28) {

                VStack(alignment: .leading, spacing: 6) {

                    Text("System Overview")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Monitor your Mac in real time.")
                        .foregroundStyle(.secondary)
                }

                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 18
                ) {

                    // MARK: - CPU

                    StatCard(
                        title: "CPU",
                        value: "\(Int(viewModel.cpuUsage))%",
                        subtitle: "Overall usage",
                        systemImage: "cpu"
                    )

                    // MARK: - Memory

                    StatCard(
                        title: "Memory",
                        value: formatBytes(viewModel.memoryUsed),
                        subtitle: "of \(formatBytes(viewModel.memoryTotal)) used",
                        systemImage: "memorychip"
                    )

                    // MARK: - Disk

                    StatCard(title:"Disk",value:formatBytes(viewModel.diskAvailable),subtitle: "Available of \(formatBytes(viewModel.diskTotal))",systemImage: "internaldrive")

                    // MARK: - Network

                    StatCard(
                        title: "Network",
                        value: formatNetworkSpeed(viewModel.downloadSpeed),
                        subtitle: "↓ Download  ↑ \(formatNetworkSpeed(viewModel.uploadSpeed))",
                        systemImage: "network"
                    )
                }
                UsageChart(
                    samples: viewModel.cpuHistory,
                    title: "CPU Usage",
                    unit: "%",
                    maximum: 100
                )
                UsageChart(samples:viewModel.memoryHistory,title:"Memory Usage",unit:"%",maximum: 100)
            }
            .padding(32)
        }
        
    }
    

    // MARK: - Byte Formatting

    private func formatBytes(_ bytes: UInt64) -> String {

        let gigabytes = Double(bytes) / 1_073_741_824.0

        return String(format: "%.1f GB", gigabytes)
    }
    private func formatNetworkSpeed(_ bytes: UInt64) -> String {

        let megabytes = Double(bytes) / 1_048_576.0

        if megabytes >= 1 {
            return String(format: "%.1f MB/s", megabytes)
        }

        let kilobytes = Double(bytes) / 1_024.0

        return String(format: "%.0f KB/s", kilobytes)
    }
}

#Preview {
    DashboardView()
        .frame(width: 900, height: 600)
}

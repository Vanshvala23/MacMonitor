import Foundation
import Combine

@MainActor
final class MenuBarViewModel: ObservableObject {

    // MARK: - CPU

    @Published private(set) var cpuUsage: Double = 0

    // MARK: - Memory

    @Published private(set) var memoryUsed: UInt64 = 0
    @Published private(set) var memoryTotal: UInt64 = 0
    @Published private(set) var memoryAvailable: UInt64 = 0

    // MARK: - Disk

    @Published private(set) var diskUsed: UInt64 = 0
    @Published private(set) var diskTotal: UInt64 = 0
    @Published private(set) var diskAvailable: UInt64 = 0

    // MARK: - Network

    @Published private(set) var downloadSpeed: UInt64 = 0
    @Published private(set) var uploadSpeed: UInt64 = 0

    // MARK: - Monitors

    private let cpuMonitor = CPUMonitor()
    private let memoryMonitor = MemoryMonitor()
    private let diskMonitor = DiskMonitor()
    private let networkMonitor = NetworkMonitor()

    private var timer: Timer?

    // MARK: - Initialization

    init() {

        update()

        timer = Timer.scheduledTimer(
            withTimeInterval: 2.0,
            repeats: true
        ) { [weak self] _ in

            self?.update()
        }
    }

    // MARK: - Update

    private func update() {

        // CPU

        cpuUsage = cpuMonitor.cpuUsage()

        // Memory

        let memory =
            memoryMonitor.getMemoryUsage()

        memoryUsed = memory.used
        memoryTotal = memory.total
        memoryAvailable = memory.available

        // Disk

        let disk =
            diskMonitor.getDiskUsage()

        diskUsed = disk.used
        diskTotal = disk.total
        diskAvailable = disk.available

        // Network

        let network =
            networkMonitor.getNetworkUsage()

        downloadSpeed =
            network.downloadBytesPerSecond

        uploadSpeed =
            network.uploadBytesPerSecond
    }

    // MARK: - Memory Percentage

    var memoryUsagePercentage: Double {

        guard memoryTotal > 0 else {
            return 0
        }

        return (
            Double(memoryUsed) /
            Double(memoryTotal)
        ) * 100
    }

    // MARK: - Disk Percentage

    var diskUsagePercentage: Double {

        guard diskTotal > 0 else {
            return 0
        }

        return (
            Double(diskUsed) /
            Double(diskTotal)
        ) * 100
    }

    // MARK: - Cleanup

    deinit {

        timer?.invalidate()
    }
}

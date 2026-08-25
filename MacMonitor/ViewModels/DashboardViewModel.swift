import Foundation
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {

    // MARK: - CPU

    @Published private(set) var cpuUsage: Double = 0
    @Published private(set) var cpuHistory: [MetricSample] = []

    // MARK: - Memory

    @Published private(set) var memoryUsed: UInt64 = 0
    @Published private(set) var memoryTotal: UInt64 = 0
    @Published private(set) var memoryAvailable: UInt64 = 0
    @Published private(set) var memoryHistory:[MetricSample]=[]

    // MARK: - Disk

    @Published private(set) var diskUsed: UInt64 = 0
    @Published private(set) var diskTotal: UInt64 = 0
    @Published private(set) var diskAvailable: UInt64 = 0
    @Published private(set) var diskHistory:[MetricSample]=[]

    // MARK: - Network

    @Published private(set) var downloadSpeed: UInt64 = 0
    @Published private(set) var uploadSpeed: UInt64 = 0

    @Published private(set) var totalDownloaded: UInt64 = 0
    @Published private(set) var totalUploaded: UInt64 = 0
    @Published private(set) var downloadHistory: [MetricSample] = []
    @Published private(set) var uploadHistory: [MetricSample] = []

    // MARK: - Monitors

    private let cpuMonitor = CPUMonitor()
    private let memoryMonitor = MemoryMonitor()
    private let diskMonitor = DiskMonitor()
    private let networkMonitor = NetworkMonitor()

    private var timer: Timer?

    // MARK: - Initialization

    init() {
        updateStats()

        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in

            guard let self else {
                return
            }

            self.updateStats()
        }
    }

    // MARK: - Update

    private func updateStats() {

        // CPU
        let cpu = cpuMonitor.cpuUsage()

        cpuUsage = cpu

        // Add CPU sample to history
        cpuHistory.append(
            MetricSample(
                timestamps: Date(),
                value: cpu
            )
        )

        // Keep only the latest 60 samples
        if cpuHistory.count > 60 {
            cpuHistory.removeFirst()
        }

        // Memory
        let memory = memoryMonitor.getMemoryUsage()

        memoryUsed = memory.used
        memoryTotal = memory.total
        memoryAvailable = memory.available
        
        let memoryPercentage: Double

        if memory.total > 0 {
            memoryPercentage =
                (Double(memory.used) / Double(memory.total)) * 100
        } else {
            memoryPercentage = 0
        }

        memoryHistory.append(
            MetricSample(
                timestamps: Date(),
                value: memoryPercentage
            )
        )

        if memoryHistory.count > 60 {
            memoryHistory.removeFirst()
        }

        // Disk
        let disk = diskMonitor.getDiskUsage()

        diskUsed = disk.used
        diskTotal = disk.total
        diskAvailable = disk.available

        // Network
        let network = networkMonitor.getNetworkUsage()

        downloadSpeed = network.downloadBytesPerSecond
        uploadSpeed = network.uploadBytesPerSecond
        
        downloadHistory.append(
            MetricSample(
                timestamps: Date(),
                value: Double(network.downloadBytesPerSecond)
            )
        )

        uploadHistory.append(
            MetricSample(
                timestamps: Date(),
                value: Double(network.uploadBytesPerSecond)
            )
        )

        if downloadHistory.count > 60 {
            downloadHistory.removeFirst()
        }

        if uploadHistory.count > 60 {
            uploadHistory.removeFirst()
        }

        totalDownloaded = network.totalDownloaded
        totalUploaded = network.totalUploaded
    }

    // MARK: - Disk Percentage

    var diskUsagePercentage: Double {

        guard diskTotal > 0 else {
            return 0
        }

        return (
            Double(diskUsed) / Double(diskTotal)
        ) * 100
    }

    // MARK: - Cleanup

    deinit {
        timer?.invalidate()
    }
}

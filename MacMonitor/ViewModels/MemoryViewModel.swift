import Foundation
import Combine

@MainActor
final class MemoryViewModel: ObservableObject {

    @Published private(set) var used: UInt64 = 0
    @Published private(set) var total: UInt64 = 0
    @Published private(set) var available: UInt64 = 0
    @Published private(set) var history: [MetricSample] = []

    private let monitor = MemoryMonitor()
    private var timer: Timer?

    init() {
        update()

        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            self?.update()
        }
    }

    private func update() {

        let memory = monitor.getMemoryUsage()

        used = memory.used
        total = memory.total
        available = memory.available

        let percentage: Double

        if total > 0 {
            percentage =
                (Double(used) / Double(total)) * 100
        } else {
            percentage = 0
        }

        history.append(
            MetricSample(
                timestamps: Date(),
                value: percentage
            )
        )

        if history.count > 60 {
            history.removeFirst()
        }
    }

    deinit {
        timer?.invalidate()
    }

    // MARK: - Usage Percentage

    var usagePercentage: Double {

        guard total > 0 else {
            return 0
        }

        return (
            Double(used) / Double(total)
        ) * 100
    }
}

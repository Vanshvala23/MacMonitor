import Foundation
import Combine

@MainActor
final class CPUViewModel: ObservableObject {

    @Published private(set) var usage: Double = 0
    @Published private(set) var history: [MetricSample] = []
    @Published private(set) var coreUsages: [Double] = []

    private let monitor = CPUMonitor()
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

        let value = monitor.cpuUsage()
        let cores=monitor.coreUsages()

        usage = value
        coreUsages=cores

        history.append(
            MetricSample(
                timestamps: Date(),
                value: value
            )
        )

        if history.count > 60 {
            history.removeFirst()
        }
    }

    deinit {
        timer?.invalidate()
    }
}

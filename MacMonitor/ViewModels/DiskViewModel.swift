//
//  DiskViewModel.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import Foundation
import Combine

@MainActor
final class DiskViewModel: ObservableObject {

    @Published private(set) var used: UInt64 = 0
    @Published private(set) var total: UInt64 = 0
    @Published private(set) var available: UInt64 = 0

    private let monitor = DiskMonitor()
    private var timer: Timer?

    init() {
        update()

        timer = Timer.scheduledTimer(
            withTimeInterval: 2.0,
            repeats: true
        ) { [weak self] _ in
            self?.update()
        }
    }

    private func update() {

        let disk = monitor.getDiskUsage()

        used = disk.used
        total = disk.total
        available = disk.available
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
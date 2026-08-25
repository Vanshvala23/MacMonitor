//
//  NetworkViewModel.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import Foundation
import Combine

@MainActor
final class NetworkViewModel: ObservableObject {

    @Published private(set) var downloadSpeed: UInt64 = 0
    @Published private(set) var uploadSpeed: UInt64 = 0

    @Published private(set) var totalDownloaded: UInt64 = 0
    @Published private(set) var totalUploaded: UInt64 = 0

    @Published private(set) var downloadHistory: [MetricSample] = []
    @Published private(set) var uploadHistory: [MetricSample] = []

    private let monitor = NetworkMonitor()
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

        let network = monitor.getNetworkUsage()

        downloadSpeed =
            network.downloadBytesPerSecond

        uploadSpeed =
            network.uploadBytesPerSecond

        totalDownloaded =
            network.totalDownloaded

        totalUploaded =
            network.totalUploaded

        let now = Date()

        downloadHistory.append(
            MetricSample(
                timestamps: now,
                value: Double(downloadSpeed)
            )
        )

        uploadHistory.append(
            MetricSample(
                timestamps: now,
                value: Double(uploadSpeed)
            )
        )

        if downloadHistory.count > 60 {
            downloadHistory.removeFirst()
        }

        if uploadHistory.count > 60 {
            uploadHistory.removeFirst()
        }
    }

    deinit {
        timer?.invalidate()
    }
}
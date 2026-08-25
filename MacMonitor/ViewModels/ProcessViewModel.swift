//
//  ProcessViewModel.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import Foundation
import Combine

@MainActor
final class ProcessViewModel: ObservableObject {

    @Published private(set) var processes: [ProcessInfo] = []

    @Published var searchText: String = ""

    private let monitor = ProcessMonitor()

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

        processes = monitor.processes()
            .sorted {
                $0.cpuUsage > $1.cpuUsage
            }
    }

    var filteredProcesses: [ProcessInfo] {

        guard !searchText.isEmpty else {
            return processes
        }

        return processes.filter {

            $0.name.localizedCaseInsensitiveContains(
                searchText
            )
        }
    }

    deinit {
        timer?.invalidate()
    }
}
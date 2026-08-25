import Foundation
import Darwin

final class CPUMonitor {

    // MARK: - Overall CPU

    private var previousUser: UInt32 = 0
    private var previousSystem: UInt32 = 0
    private var previousIdle: UInt32 = 0
    private var previousNice: UInt32 = 0

    // MARK: - CPU Core Data

    private var previousCoreTicks: [CoreTicks] = []

    // MARK: - Overall CPU Usage

    func cpuUsage() -> Double {

        var size = mach_msg_type_number_t(
            MemoryLayout<host_cpu_load_info_data_t>.size
            / MemoryLayout<integer_t>.size
        )

        var cpuLoad = host_cpu_load_info()

        let result = withUnsafeMutablePointer(
            to: &cpuLoad
        ) {

            $0.withMemoryRebound(
                to: integer_t.self,
                capacity: Int(size)
            ) {

                host_statistics(
                    mach_host_self(),
                    HOST_CPU_LOAD_INFO,
                    $0,
                    &size
                )
            }
        }

        guard result == KERN_SUCCESS else {
            return 0
        }

        let user = cpuLoad.cpu_ticks.0
        let system = cpuLoad.cpu_ticks.1
        let idle = cpuLoad.cpu_ticks.2
        let nice = cpuLoad.cpu_ticks.3

        let userDelta = user - previousUser
        let systemDelta = system - previousSystem
        let idleDelta = idle - previousIdle
        let niceDelta = nice - previousNice

        previousUser = user
        previousSystem = system
        previousIdle = idle
        previousNice = nice

        let total =
            userDelta +
            systemDelta +
            idleDelta +
            niceDelta

        guard total > 0 else {
            return 0
        }

        let active =
            userDelta +
            systemDelta +
            niceDelta

        return (
            Double(active) / Double(total)
        ) * 100
    }

    // MARK: - CPU Core Usage

    func coreUsages() -> [Double] {

        var processorCount: natural_t = 0

        var processorInfo: processor_info_array_t?

        var processorInfoCount: mach_msg_type_number_t = 0

        let result = host_processor_info(
            mach_host_self(),
            PROCESSOR_CPU_LOAD_INFO,
            &processorCount,
            &processorInfo,
            &processorInfoCount
        )

        guard result == KERN_SUCCESS,
              let processorInfo
        else {
            return []
        }

        defer {

            let size = vm_size_t(
                processorInfoCount
                * mach_msg_type_number_t(
                    MemoryLayout<integer_t>.size
                )
            )

            vm_deallocate(
                mach_task_self_,
                vm_address_t(
                    UInt(bitPattern: processorInfo)
                ),
                size
            )
        }

        let cpuTicks = UnsafeMutablePointer<integer_t>(
            processorInfo
        )

        var currentCoreTicks: [CoreTicks] = []

        for core in 0..<Int(processorCount) {

            let offset =
                core * Int(CPU_STATE_MAX)

            currentCoreTicks.append(
                CoreTicks(
                    user: UInt64(
                        max(
                            0,
                            cpuTicks[
                                offset + Int(CPU_STATE_USER)
                            ]
                        )
                    ),

                    system: UInt64(
                        max(
                            0,
                            cpuTicks[
                                offset + Int(CPU_STATE_SYSTEM)
                            ]
                        )
                    ),

                    idle: UInt64(
                        max(
                            0,
                            cpuTicks[
                                offset + Int(CPU_STATE_IDLE)
                            ]
                        )
                    ),

                    nice: UInt64(
                        max(
                            0,
                            cpuTicks[
                                offset + Int(CPU_STATE_NICE)
                            ]
                        )
                    )
                )
            )
        }

        // First call establishes baseline.

        guard currentCoreTicks.count ==
                previousCoreTicks.count
        else {

            previousCoreTicks = currentCoreTicks

            return Array(
                repeating: 0,
                count: currentCoreTicks.count
            )
        }

        var usages: [Double] = []

        for index in currentCoreTicks.indices {

            let current = currentCoreTicks[index]

            let previous = previousCoreTicks[index]

            let userDelta =
                current.user >= previous.user
                ? current.user - previous.user
                : 0

            let systemDelta =
                current.system >= previous.system
                ? current.system - previous.system
                : 0

            let idleDelta =
                current.idle >= previous.idle
                ? current.idle - previous.idle
                : 0

            let niceDelta =
                current.nice >= previous.nice
                ? current.nice - previous.nice
                : 0

            let total =
                userDelta +
                systemDelta +
                idleDelta +
                niceDelta

            guard total > 0 else {

                usages.append(0)

                continue
            }

            let active =
                userDelta +
                systemDelta +
                niceDelta

            let usage =
                (Double(active) / Double(total)) * 100

            usages.append(
                max(
                    0,
                    min(100, usage)
                )
            )
        }

        previousCoreTicks = currentCoreTicks

        return usages
    }
}

// MARK: - Core Tick Model

private struct CoreTicks {

    let user: UInt64
    let system: UInt64
    let idle: UInt64
    let nice: UInt64
}

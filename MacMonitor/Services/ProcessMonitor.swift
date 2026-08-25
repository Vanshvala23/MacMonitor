//
//  ProcessMonitor.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import Foundation

final class ProcessMonitor {

    func processes() -> [ProcessInfo] {

        let process = Process()

        let pipe = Pipe()

        process.executableURL = URL(
            fileURLWithPath: "/bin/ps"
        )

        process.arguments = [
            "-axo",
            "pid=,comm=,%cpu=,rss="
        ]

        process.standardOutput = pipe

        do {

            try process.run()

            process.waitUntilExit()

            let data =
                pipe.fileHandleForReading.readDataToEndOfFile()

            guard let output = String(
                data: data,
                encoding: .utf8
            ) else {
                return []
            }

            return parse(output)

        } catch {

            print(
                "ProcessMonitor error:",
                error
            )

            return []
        }
    }

    private func parse(
        _ output: String
    ) -> [ProcessInfo] {

        var result: [ProcessInfo] = []

        for line in output.components(separatedBy: .newlines) {

            let parts = line
                .split(
                    whereSeparator: { $0 == " " || $0 == "\t" }
                )

            guard parts.count >= 4 else {
                continue
            }

            guard let pid = Int(parts[0]) else {
                continue
            }

            let name = String(parts[1])

            let cpu = Double(parts[2]) ?? 0

            let memoryKB =
                UInt64(parts[3]) ?? 0

            let memoryBytes =
                memoryKB * 1024

            result.append(
                ProcessInfo(
                    id: pid,
                    name: name,
                    cpuUsage: cpu,
                    memoryUsage: memoryBytes
                )
            )
        }

        return result
    }
}
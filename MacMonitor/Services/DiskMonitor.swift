import Foundation

final class DiskMonitor {

    struct DiskUsage {
        let total: UInt64
        let used: UInt64
        let available: UInt64
    }

    func getDiskUsage() -> DiskUsage {

        let fileManager = FileManager.default

        guard let attributes = try? fileManager.attributesOfFileSystem(
            forPath: "/"
        ) else {
            return DiskUsage(
                total: 0,
                used: 0,
                available: 0
            )
        }

        let total = attributes[
            .systemSize
        ] as? UInt64 ?? 0

        let free = attributes[
            .systemFreeSize
        ] as? UInt64 ?? 0

        let used = total > free
            ? total - free
            : 0

        return DiskUsage(
            total: total,
            used: used,
            available: free
        )
    }
}

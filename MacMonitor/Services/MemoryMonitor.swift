
import Foundation

final class MemoryMonitor {

    struct MemoryUsage {
        let used: UInt64
        let total: UInt64
        let available: UInt64
    }

    func getMemoryUsage() -> MemoryUsage {

        let totalMemory = Foundation.ProcessInfo.processInfo.physicalMemory

        var statistics = vm_statistics64()
        var count = mach_msg_type_number_t(
            MemoryLayout<vm_statistics64_data_t>.size
            / MemoryLayout<integer_t>.size
        )

        let result = withUnsafeMutablePointer(to: &statistics) {
            $0.withMemoryRebound(
                to: integer_t.self,
                capacity: Int(count)
            ) {
                host_statistics64(
                    mach_host_self(),
                    HOST_VM_INFO64,
                    $0,
                    &count
                )
            }
        }

        guard result == KERN_SUCCESS else {
            return MemoryUsage(
                used: 0,
                total: totalMemory,
                available: totalMemory
            )
        }

        let pageSize = UInt64(vm_kernel_page_size)

        let active = UInt64(statistics.active_count) * pageSize
        let inactive = UInt64(statistics.inactive_count) * pageSize
        let wired = UInt64(statistics.wire_count) * pageSize
        let compressed = UInt64(statistics.compressor_page_count) * pageSize

        let used = active + inactive + wired + compressed

        let available = totalMemory > used
            ? totalMemory - used
            : 0

        return MemoryUsage(
            used: used,
            total: totalMemory,
            available: available
        )
    }
}

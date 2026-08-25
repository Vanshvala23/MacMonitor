import Foundation

extension UInt64 {

    var gigabytes: Double {
        Double(self) / 1_073_741_824
    }

    var formattedGigabytes: String {
        String(format: "%.1f GB", gigabytes)
    }
}

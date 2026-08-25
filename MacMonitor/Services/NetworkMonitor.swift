//
//  NetworkMonitor.swift
//  MacMonitor
//
//  Created by Vansh Vala on 25/08/26.
//


import Foundation

final class NetworkMonitor {

    struct NetworkUsage {
        let downloadBytesPerSecond: UInt64
        let uploadBytesPerSecond: UInt64
        let totalDownloaded: UInt64
        let totalUploaded: UInt64
    }

    private var previousDownloadBytes: UInt64 = 0
    private var previousUploadBytes: UInt64 = 0

    private var hasPreviousSample = false

    func getNetworkUsage() -> NetworkUsage {

        var downloadBytes: UInt64 = 0
        var uploadBytes: UInt64 = 0

        var interfaces: UnsafeMutablePointer<ifaddrs>?

        guard getifaddrs(&interfaces) == 0,
              let firstInterface = interfaces else {
            return NetworkUsage(
                downloadBytesPerSecond: 0,
                uploadBytesPerSecond: 0,
                totalDownloaded: 0,
                totalUploaded: 0
            )
        }

        var currentInterface: UnsafeMutablePointer<ifaddrs>?
        currentInterface = firstInterface

        while currentInterface != nil {

            guard let interface = currentInterface?.pointee else {
                break
            }

            if let address = interface.ifa_addr {

                let family = address.pointee.sa_family

                if family == UInt8(AF_LINK) {

                    let data = interface.ifa_data
                        .assumingMemoryBound(
                            to: if_data.self
                        )

                    downloadBytes += UInt64(
                        data.pointee.ifi_ibytes
                    )

                    uploadBytes += UInt64(
                        data.pointee.ifi_obytes
                    )
                }
            }

            currentInterface = interface.ifa_next
        }

        freeifaddrs(interfaces)

        var downloadSpeed: UInt64 = 0
        var uploadSpeed: UInt64 = 0

        if hasPreviousSample {

            if downloadBytes >= previousDownloadBytes {
                downloadSpeed =
                    downloadBytes - previousDownloadBytes
            }

            if uploadBytes >= previousUploadBytes {
                uploadSpeed =
                    uploadBytes - previousUploadBytes
            }
        }

        previousDownloadBytes = downloadBytes
        previousUploadBytes = uploadBytes

        hasPreviousSample = true

        return NetworkUsage(
            downloadBytesPerSecond: downloadSpeed,
            uploadBytesPerSecond: uploadSpeed,
            totalDownloaded: downloadBytes,
            totalUploaded: uploadBytes
        )
    }
}
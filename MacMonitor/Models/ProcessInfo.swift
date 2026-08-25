//
//  ProcessInfo.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import Foundation

struct ProcessInfo: Identifiable {

    let id: Int
    let name: String
    let cpuUsage: Double
    let memoryUsage: UInt64
}
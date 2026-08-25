import Foundation
enum SidebarSection:String, CaseIterable, Identifiable{
    case overview
    case cpu
    case memory
    case disk
    case network
    case processes
    case settings
    
    var id:String{
            rawValue
    }
    var title:String{
        switch self{
        case .overview:
                    "Overview"
                case .cpu:
                    "CPU"
                case .memory:
                    "Memory"
                case .disk:
                    "Disk"
                case .network:
                    "Network"
                case .processes:
                    "Processes"
                case .settings:
                    "Settings"
        }
    }
    var systemImage:String{
        switch self{
        case .overview:"square.grid.2x2"
        case .cpu:"cpu"
        case .memory:"memorychip"
        case .disk:"internaldrive"
        case .network:"network"
        case .processes:"list.bullet.rectangle"
        case .settings:"gearshape"
        }
    }
}


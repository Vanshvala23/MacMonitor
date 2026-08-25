import SwiftUI

struct DetailView: View {
    let section: SidebarSection

    var body: some View {
        switch section {
        case .overview:
            DashboardView()

        case .cpu:
            CPUView()

        case .memory:
            MemoryView()

        case .disk:
            DiskView()

        case .network:
            NetworkView()

        case .processes:
            ProcessesView()

        case .settings:
           SettingsView()
        }
    }
}

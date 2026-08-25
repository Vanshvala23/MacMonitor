import SwiftUI

struct MainView: View {
    @State private var selectedSection: SidebarSection = .overview

    var body: some View {
        NavigationSplitView {
            SidebarView(selectedSection: $selectedSection)
        } detail: {
            DetailView(section: selectedSection)
        }
        .frame(minWidth: 1000, minHeight: 650)
    }
}

#Preview {
    MainView()
}

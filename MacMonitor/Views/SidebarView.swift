import SwiftUI
struct SidebarView:View{
    @Binding var selectedSection:SidebarSection
    var body:some View{
        List(selection:$selectedSection){
            Section{
                ForEach(SidebarSection.allCases){
                    section in
                    Label{
                        Text(section.title)
                    }
                    icon:{
                        Image(systemName:section.systemImage)
                    }.tag(section)
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("MacMonitor")
    }
}
#Preview {
    SidebarView(selectedSection: .constant(.overview))
}

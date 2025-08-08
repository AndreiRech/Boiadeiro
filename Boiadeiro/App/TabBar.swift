import SwiftUI

struct TabBar: View {
    @State private var selectedTabIndex: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            NavigationStack {
                Batches()
            }
            .tabItem {
                Image(selectedTabIndex == 0 ? "CowIcon-Selected" : "CowIcon")
                Text("Lotes")
            }
            .tag(0)
            
            NavigationStack {
                Statistics()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Estatísticas")
            }
            .tag(1)
                        
            NavigationStack {
                Profile()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(2)
        }
    }
}

#Preview {
    TabBar()
}

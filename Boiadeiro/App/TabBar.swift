import SwiftUI

struct TabBar: View {
    @State private var selectedTabIndex: Int = 0
    @State private var showSplash: Bool = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreen()
                    .transition(.opacity)
            } else {
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
                        Statistics(selectedTab: $selectedTabIndex)
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
        .animation(.easeInOut(duration: 1), value: showSplash)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.showSplash = false
                }
            }
        }
    }
}

#Preview {
    TabBar()
}

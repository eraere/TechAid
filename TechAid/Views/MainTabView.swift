import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            LearningPathView()
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("Learn")
                }
                .tag(1)
            
            SupportView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Support")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
    }
} 
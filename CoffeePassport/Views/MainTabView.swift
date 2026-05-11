import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            PassportView()
                .tabItem {
                    Label("Passport", systemImage: "book.closed.fill")
                }

            MapView()
                .tabItem {
                    Label("Map", systemImage: "mappin.and.ellipse")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .tint(Theme.coffee)
    }
}

#Preview {
    MainTabView()
}

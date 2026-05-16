import CoreLocation
import SwiftUI

struct MainTabView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var coffeeShopService = CoffeeShopService()
    @State private var hasFetched = false

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            PassportView()
                .tabItem { Label("Passport", systemImage: "book.closed.fill") }

            MapView()
                .tabItem { Label("Map", systemImage: "mappin.and.ellipse") }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
        .tint(Theme.coffee)
        .environmentObject(locationManager)
        .environmentObject(coffeeShopService)
        .onChange(of: locationManager.location) { _, location in
            guard let loc = location, !hasFetched else { return }
            hasFetched = true
            Task {
                await coffeeShopService.fetchCoffeeShops(
                    lat: loc.coordinate.latitude,
                    lng: loc.coordinate.longitude
                )
            }
        }
    }
}

#Preview {
    MainTabView()
}

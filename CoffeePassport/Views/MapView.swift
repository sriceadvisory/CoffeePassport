import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var service: CoffeeShopService

    @State private var selectedMode = MapDisplayMode.list
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Coffee Map")
                .font(.largeTitle.bold())
                .foregroundStyle(Theme.espresso)

            Picker("View", selection: $selectedMode) {
                ForEach(MapDisplayMode.allCases) { mode in
                    Text(mode.title).tag(mode)
                }
            }
            .pickerStyle(.segmented)

            switch selectedMode {
            case .list:
                shopList
            case .map:
                coffeeMap
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .background(Theme.cream.ignoresSafeArea())
        .onChange(of: locationManager.location) { _, location in
            guard let loc = location else { return }
            cameraPosition = .region(MKCoordinateRegion(
                center: loc.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        }
    }

    private var coffeeMap: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(service.places) { place in
                Marker(
                    place.name,
                    systemImage: "cup.and.saucer.fill",
                    coordinate: CLLocationCoordinate2D(
                        latitude: place.geocodes.main.latitude,
                        longitude: place.geocodes.main.longitude
                    )
                )
                .tint(Theme.coffee)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 26))
    }

    private var shopList: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                SectionHeader(title: "Nearby")

                if service.places.isEmpty {
                    VStack(spacing: 12) {
                        ProgressView()
                        Text("Finding coffee shops…")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 40)
                } else {
                    ForEach(service.places) { place in
                        FoursquarePlaceRow(place: place)
                    }
                }
            }
        }
    }
}

struct FoursquarePlaceRow: View {
    let place: FoursquarePlace

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(
                    colors: [Theme.coffee, Theme.caramel],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.title3)
                        .foregroundStyle(Theme.cream)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(place.name)
                    .font(.headline)
                    .foregroundStyle(Theme.espresso)

                if let address = place.location.address {
                    Text(address)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                if let city = place.location.city {
                    Text(city)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding(12)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

private enum MapDisplayMode: String, CaseIterable, Identifiable {
    case list
    case map

    var id: Self { self }

    var title: String {
        switch self {
        case .list: "List"
        case .map: "Map"
        }
    }
}

#Preview {
    MapView()
        .environmentObject(LocationManager())
        .environmentObject(CoffeeShopService())
}

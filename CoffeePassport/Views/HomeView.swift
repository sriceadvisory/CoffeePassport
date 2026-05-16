import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var service: CoffeeShopService

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    HStack {
                        Label("Coffee Passport", systemImage: "cup.and.saucer.fill")
                            .font(.largeTitle.bold())
                            .foregroundStyle(Theme.espresso)
                        Spacer()
                        Image(systemName: "bell")
                            .font(.title2)
                    }

                    Text("Good morning, Shon 👋")
                        .font(.title.bold())
                        .foregroundStyle(Theme.espresso)

                    SummaryCard()

                    SectionHeader(title: "Your Passport", actionTitle: "View all", destination: PassportView())
                    StampPreviewRow()

                    MapPreviewCard(
                        places: service.places,
                        userLocation: locationManager.location?.coordinate
                    )

                    SectionHeader(title: "Nearby Coffee Shops", actionTitle: "See all", destination: MapView())

                    if service.places.isEmpty {
                        VStack(spacing: 10) {
                            ProgressView()
                            Text("Loading nearby shops…")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 12)
                    } else {
                        ForEach(service.places) { place in
                            FoursquarePlaceRow(place: place)
                        }
                    }

                    Button {
                    } label: {
                        Label("Scan for Stamp", systemImage: "qrcode.viewfinder")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.coffee)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                }
                .padding()
            }
            .background(Theme.cream.ignoresSafeArea())
        }
    }
}

private struct SummaryCard: View {
    var body: some View {
        VStack(spacing: 18) {
            HStack(spacing: 18) {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 62))
                    .foregroundStyle(Theme.softGreen)

                StatBlock(icon: "seal.fill", number: "12", label: "Stamps")
                StatBlock(icon: "flame.fill", number: "3", label: "Day streak")
                StatBlock(icon: "building.2.fill", number: "3", label: "New cafés")
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Label("2 stamps until next reward", systemImage: "gift.fill")
                    Spacer()
                    Text("10 / 12")
                }
                .foregroundStyle(.white)

                ProgressView(value: 10, total: 12)
                    .tint(Theme.softGreen)
            }
        }
        .padding()
        .background(Theme.espresso)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

private struct StatBlock: View {
    let icon: String
    let number: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(Theme.caramel)
            Text(number)
                .font(.title.bold())
                .foregroundStyle(.white)
            Text(label)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.85))
        }
        .frame(maxWidth: .infinity)
    }
}

private struct StampPreviewRow: View {
    var body: some View {
        HStack {
            ForEach(SampleData.stamps.prefix(6)) { stamp in
                Image(systemName: stamp.isCollected ? stamp.icon : "circle.dashed")
                    .font(.title2)
                    .foregroundStyle(stamp.isCollected ? Theme.coffee : .secondary)
                    .frame(width: 48, height: 48)
                    .background(stamp.isCollected ? Theme.cream : Color.clear)
                    .clipShape(Circle())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

private struct MapPreviewCard: View {
    let places: [FoursquarePlace]
    let userLocation: CLLocationCoordinate2D?

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: userLocation ?? CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    }

    var body: some View {
        Map(initialPosition: .region(region)) {
            if let coord = userLocation {
                Annotation("You", coordinate: coord) {
                    Image(systemName: "location.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
            }
            ForEach(places.prefix(10)) { place in
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
        .frame(height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .disabled(true)
    }
}

#Preview {
    HomeView()
        .environmentObject(LocationManager())
        .environmentObject(CoffeeShopService())
}

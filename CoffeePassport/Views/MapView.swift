import SwiftUI
import MapKit

struct MapView: View {
    @State private var selectedMode = MapDisplayMode.list
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611),
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        )
    )

    private let shopLocations = [
        CoffeeShopLocation(shop: SampleData.shops[0], coordinate: CLLocationCoordinate2D(latitude: 32.7242, longitude: -117.1688)),
        CoffeeShopLocation(shop: SampleData.shops[1], coordinate: CLLocationCoordinate2D(latitude: 32.7110, longitude: -117.1537)),
        CoffeeShopLocation(shop: SampleData.shops[2], coordinate: CLLocationCoordinate2D(latitude: 32.7488, longitude: -117.1293))
    ]

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
    }

    private var coffeeMap: some View {
        Map(position: $cameraPosition) {
            ForEach(shopLocations) { location in
                Marker(location.shop.name, systemImage: "cup.and.saucer.fill", coordinate: location.coordinate)
                    .tint(Theme.coffee)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 26))
    }

    private var shopList: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Nearby")

            ForEach(SampleData.shops.prefix(5)) { shop in
                CoffeeShopRow(shop: shop)
            }
        }
    }
}

private enum MapDisplayMode: String, CaseIterable, Identifiable {
    case list
    case map

    var id: Self { self }

    var title: String {
        switch self {
        case .list:
            "List"
        case .map:
            "Map"
        }
    }
}

private struct CoffeeShopLocation: Identifiable {
    let shop: CoffeeShop
    let coordinate: CLLocationCoordinate2D

    var id: CoffeeShop.ID { shop.id }
}

#Preview {
    MapView()
}

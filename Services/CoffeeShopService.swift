import Combine
import Foundation

@MainActor
class CoffeeShopService: ObservableObject {
    @Published var places: [FoursquarePlace] = []

    private let apiKey = ""  // Fill in your Foursquare API key here

    func fetchCoffeeShops(lat: Double, lng: Double) async {
        var components = URLComponents(string: "https://api.foursquare.com/v3/places/search")!
        components.queryItems = [
            URLQueryItem(name: "query", value: "coffee"),
            URLQueryItem(name: "categories", value: "13032"),
            URLQueryItem(name: "ll", value: "\(lat),\(lng)"),
            URLQueryItem(name: "radius", value: "2000"),
            URLQueryItem(name: "limit", value: "20")
        ]

        guard let url = components.url else { return }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(FoursquareResponse.self, from: data)
            places = response.results
        } catch {
            print("Failed to fetch coffee shops: \(error)")
        }
    }
}

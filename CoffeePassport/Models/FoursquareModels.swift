import Foundation

struct FoursquarePlace: Identifiable, Decodable {
    let id: String
    let name: String
    let geocodes: Geocodes
    let location: Location

    struct Geocodes: Decodable {
        let main: Coordinates

        struct Coordinates: Decodable {
            let latitude: Double
            let longitude: Double
        }
    }

    struct Location: Decodable {
        let address: String?
        let city: String?
    }
}

struct FoursquareResponse: Decodable {
    let results: [FoursquarePlace]
}

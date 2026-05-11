import Foundation

struct CoffeeShop: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let neighborhood: String
    let distance: String
    let rating: Double
    let reviewCount: Int
    let imageName: String
    let stampAvailable: Bool
}

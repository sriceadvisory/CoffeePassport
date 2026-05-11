import Foundation

struct Stamp: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let title: String
    let isCollected: Bool
}

import Foundation

struct Reward: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let isUnlocked: Bool
}

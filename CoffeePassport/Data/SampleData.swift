import Foundation

struct SampleData {
    static let shops: [CoffeeShop] = [
        CoffeeShop(
            name: "Harbor Roast",
            neighborhood: "Little Italy",
            distance: "0.2 mi",
            rating: 4.6,
            reviewCount: 128,
            imageName: "coffeeShop1",
            stampAvailable: true
        ),
        CoffeeShop(
            name: "Morning Foundry",
            neighborhood: "East Village",
            distance: "0.4 mi",
            rating: 4.4,
            reviewCount: 96,
            imageName: "coffeeShop2",
            stampAvailable: true
        ),
        CoffeeShop(
            name: "Velvet Bean",
            neighborhood: "North Park",
            distance: "0.7 mi",
            rating: 4.7,
            reviewCount: 210,
            imageName: "coffeeShop3",
            stampAvailable: true
        )
    ]

    static let stamps: [Stamp] = [
        Stamp(icon: "cup.and.saucer.fill", title: "Classic Cup", isCollected: true),
        Stamp(icon: "mug.fill", title: "Morning Mug", isCollected: true),
        Stamp(icon: "leaf.fill", title: "Latte Art", isCollected: true),
        Stamp(icon: "circle.hexagongrid.fill", title: "Roast Badge", isCollected: true),
        Stamp(icon: "takeoutbag.and.cup.and.straw.fill", title: "To Go", isCollected: true),
        Stamp(icon: "building.2.fill", title: "Café Visit", isCollected: true),
        Stamp(icon: "flame.fill", title: "Streak", isCollected: true),
        Stamp(icon: "gift.fill", title: "Reward", isCollected: true),
        Stamp(icon: "star.fill", title: "Favorite", isCollected: true),
        Stamp(icon: "location.fill", title: "Explorer", isCollected: true),
        Stamp(icon: "11.circle", title: "Locked", isCollected: false),
        Stamp(icon: "12.circle", title: "Locked", isCollected: false)
    ]

    static let rewards: [Reward] = [
        Reward(title: "Free Pastry", subtitle: "Unlocked", icon: "birthday.cake.fill", isUnlocked: true),
        Reward(title: "Free Drink", subtitle: "at 12 stamps", icon: "cup.and.saucer.fill", isUnlocked: false),
        Reward(title: "Coffee Flight", subtitle: "at 20 stamps", icon: "tray.fill", isUnlocked: false)
    ]
}

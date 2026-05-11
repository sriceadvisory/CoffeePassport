import SwiftUI

struct CoffeeShopRow: View {
    let shop: CoffeeShop
    var showFavorite: Bool = false

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(colors: [Theme.coffee, Theme.caramel], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 88, height: 70)
                .overlay {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.title2)
                        .foregroundStyle(Theme.cream)
                }

            VStack(alignment: .leading, spacing: 5) {
                Text(shop.name)
                    .font(.headline)
                    .foregroundStyle(Theme.espresso)

                Text("\(shop.neighborhood) • Coffee Shop")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 3) {
                    ForEach(0..<5, id: \.self) { index in
                        Image(systemName: index < Int(shop.rating.rounded(.down)) ? "star.fill" : "star")
                            .font(.caption)
                            .foregroundStyle(.yellow)
                    }
                    Text("\(shop.rating, specifier: "%.1f") (\(shop.reviewCount))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            if showFavorite {
                Image(systemName: "heart.fill")
                    .foregroundStyle(Theme.coffee)
            } else {
                VStack(alignment: .trailing, spacing: 8) {
                    Text(shop.distance)
                        .font(.subheadline)
                        .foregroundStyle(Theme.espresso)

                    if shop.stampAvailable {
                        Text("Stamp available")
                            .font(.caption2.weight(.semibold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(Theme.softGreen)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding(12)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

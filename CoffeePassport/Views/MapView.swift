import SwiftUI

struct MapView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Coffee Map")
                .font(.largeTitle.bold())
                .foregroundStyle(Theme.espresso)

            ZStack {
                RoundedRectangle(cornerRadius: 26)
                    .fill(LinearGradient(colors: [.green.opacity(0.18), .blue.opacity(0.15), Theme.card], startPoint: .topLeading, endPoint: .bottomTrailing))

                ForEach(0..<7, id: \.self) { index in
                    Image(systemName: "mappin.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(Theme.coffee)
                        .offset(x: CGFloat([-110, -80, -25, 30, 85, 120, 5][index]), y: CGFloat([-170, -40, 90, -110, 35, 150, 0][index]))
                }

                Image(systemName: "location.circle.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.blue)
            }
            .frame(maxHeight: .infinity)

            SectionHeader(title: "Nearby", actionTitle: "List")

            ForEach(SampleData.shops.prefix(2)) { shop in
                CoffeeShopRow(shop: shop)
            }
        }
        .padding()
        .background(Theme.cream.ignoresSafeArea())
    }
}

#Preview {
    MapView()
}

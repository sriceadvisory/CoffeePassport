import SwiftUI

struct PassportView: View {
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                HStack {
                    Label("Your Passport", systemImage: "book.closed.fill")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Theme.espresso)
                    Spacer()
                    Image(systemName: "slider.horizontal.3")
                        .font(.title2)
                }

                Text("Collect stamps. Unlock rewards. Discover cafés.")
                    .foregroundStyle(.secondary)

                PassportProgressCard()

                SectionHeader(title: "Stamp Pages")

                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(SampleData.stamps) { stamp in
                        StampCircle(stamp: stamp)
                    }
                }
                .padding()
                .background(Theme.card)
                .clipShape(RoundedRectangle(cornerRadius: 22))

                SectionHeader(title: "Rewards")

                HStack(spacing: 12) {
                    ForEach(SampleData.rewards) { reward in
                        RewardCard(reward: reward)
                    }
                }

                SectionHeader(title: "Recent Visits", actionTitle: "View all")

                ForEach(SampleData.shops) { shop in
                    CoffeeShopRow(shop: shop)
                }
            }
            .padding()
        }
        .background(Theme.cream.ignoresSafeArea())
    }
}

private struct PassportProgressCard: View {
    var body: some View {
        HStack(spacing: 18) {
            ZStack {
                Circle()
                    .stroke(.white.opacity(0.2), lineWidth: 12)
                Circle()
                    .trim(from: 0, to: 10 / 12)
                    .stroke(Theme.softGreen, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Image(systemName: "cup.and.saucer.fill")
                    .font(.largeTitle)
                    .foregroundStyle(Theme.cream)
            }
            .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 8) {
                Text("10 of 12")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Text("stamps collected")
                    .foregroundStyle(.white.opacity(0.9))
                Text("2 stamps until your next reward")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
                ProgressView(value: 10, total: 12)
                    .tint(Theme.softGreen)
            }

            Spacer()
        }
        .padding()
        .background(Theme.espresso)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

private struct StampCircle: View {
    let stamp: Stamp

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: stamp.isCollected ? stamp.icon : "circle.dashed")
                .font(.title2)
                .foregroundStyle(stamp.isCollected ? Theme.cream : .secondary)
                .frame(width: 58, height: 58)
                .background(stamp.isCollected ? Theme.coffee : Color.clear)
                .clipShape(Circle())

            Text(stamp.title)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}

private struct RewardCard: View {
    let reward: Reward

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: reward.icon)
                .font(.title2)
                .foregroundStyle(reward.isUnlocked ? Theme.matcha : Theme.coffee)
                .frame(width: 56, height: 56)
                .background(Theme.cream)
                .clipShape(Circle())

            Text(reward.title)
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(reward.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(reward.isUnlocked ? "Unlocked" : "Coming soon")
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(reward.isUnlocked ? Theme.softGreen : Theme.cream)
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    PassportView()
}

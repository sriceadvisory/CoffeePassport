import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                HStack {
                    Label("Profile", systemImage: "cup.and.saucer.fill")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Theme.espresso)
                    Spacer()
                    Image(systemName: "gearshape")
                        .font(.title2)
                }

                ProfileCard()

                SectionHeader(title: "Achievements", actionTitle: "View all")
                AchievementRow()

                SectionHeader(title: "Favorites", actionTitle: "View all")
                ForEach([SampleData.shops[0], SampleData.shops[2]]) { shop in
                    CoffeeShopRow(shop: shop, showFavorite: true)
                }

                SectionHeader(title: "Account & Preferences")
                PreferencesList()

                InviteFriendsCard()
            }
            .padding()
        }
        .background(Theme.cream.ignoresSafeArea())
    }
}

private struct ProfileCard: View {
    var body: some View {
        VStack(spacing: 18) {
            HStack(spacing: 16) {
                Circle()
                    .fill(LinearGradient(colors: [Theme.caramel, Theme.coffee], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 96, height: 96)
                    .overlay {
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Theme.cream)
                    }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Shon Rice")
                        .font(.title.bold())
                        .foregroundStyle(Theme.espresso)
                    Text("Coffee Explorer")
                        .foregroundStyle(.secondary)
                    Label("San Diego, CA", systemImage: "location")
                        .font(.subheadline)
                    Text("Gold Member")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.yellow.opacity(0.25))
                        .clipShape(Capsule())
                }
                Spacer()
            }

            Divider()

            HStack {
                ProfileStat(icon: "seal.fill", value: "12", label: "Stamps")
                Divider()
                ProfileStat(icon: "building.2.fill", value: "8", label: "Cafés")
                Divider()
                ProfileStat(icon: "flame.fill", value: "3", label: "Streak")
            }
            .frame(height: 54)
        }
        .padding()
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

private struct ProfileStat: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(Theme.coffee)
            VStack(alignment: .leading) {
                Text(value)
                    .font(.title3.bold())
                Text(label)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private struct AchievementRow: View {
    let achievements = [
        ("seal.fill", "First Stamp", "Earned your first stamp"),
        ("sun.max.fill", "Weekend Sipper", "Visited on a weekend"),
        ("cup.and.saucer.fill", "Latte Lover", "Collected 5 latte stamps")
    ]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(achievements, id: \.1) { item in
                VStack(spacing: 10) {
                    Image(systemName: item.0)
                        .font(.title2)
                        .foregroundStyle(Theme.cream)
                        .frame(width: 62, height: 62)
                        .background(Theme.coffee)
                        .clipShape(Circle())
                    Text(item.1)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Text(item.2)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.card)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
    }
}

private struct PreferencesList: View {
    let rows = [
        ("person", "Edit Profile"),
        ("bell", "Notifications"),
        ("gift", "Rewards History"),
        ("creditcard", "Payment Methods"),
        ("questionmark.circle", "Help & Support")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(rows, id: \.1) { row in
                HStack {
                    Image(systemName: row.0)
                        .frame(width: 28)
                    Text(row.1)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                .padding()

                if row.1 != rows.last?.1 {
                    Divider().padding(.leading, 56)
                }
            }
        }
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

private struct InviteFriendsCard: View {
    var body: some View {
        HStack {
            Image(systemName: "person.2.fill")
                .foregroundStyle(Theme.matcha)
                .font(.title2)
                .frame(width: 52, height: 52)
                .background(Theme.softGreen.opacity(0.5))
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text("Invite Friends")
                    .font(.headline)
                Text("Earn 1 bonus stamp for each friend")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button("Invite") {}
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(Theme.matcha)
                .clipShape(Capsule())
        }
        .padding()
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    ProfileView()
}

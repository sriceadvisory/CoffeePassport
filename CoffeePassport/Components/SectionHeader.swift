import SwiftUI

struct SectionHeader<Destination: View>: View {
    let title: String
    var actionTitle: String? = nil
    var destination: Destination?

    init(
        title: String,
        actionTitle: String? = nil,
        destination: Destination
    ) {
        self.title = title
        self.actionTitle = actionTitle
        self.destination = destination
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Theme.espresso)

            Spacer()

            if let actionTitle, let destination {
                NavigationLink {
                    destination
                } label: {
                    HStack(spacing: 4) {
                        Text(actionTitle)

                        Image(systemName: "chevron.right")
                            .font(.caption.weight(.semibold))
                    }
                    .font(.subheadline)
                    .foregroundStyle(Theme.coffee)
                }
            }
        }
    }
}
extension SectionHeader where Destination == EmptyView {
    init(title: String, actionTitle: String? = nil) {
        self.title = title
        self.actionTitle = actionTitle
        self.destination = nil
    }
}


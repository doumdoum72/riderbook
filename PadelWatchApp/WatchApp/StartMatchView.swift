import SwiftUI

struct StartMatchView: View {
    @EnvironmentObject var store: MatchStore
    @State private var myTeamName = "Moi"
    @State private var opponentTeamName = "Adversaires"

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Padel").font(.headline)

                Button {
                    store.startMatch(myTeamName: myTeamName, opponentTeamName: opponentTeamName)
                } label: {
                    Label("Nouveau match", systemImage: "play.fill")
                }
                .buttonStyle(.borderedProminent)

                NavigationLink(destination: HistoryView()) {
                    Label("Historique", systemImage: "clock.arrow.circlepath")
                }
            }
            .padding()
        }
        .navigationTitle("Padel")
    }
}

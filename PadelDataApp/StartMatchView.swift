import SwiftUI

struct StartMatchView: View {
    @EnvironmentObject var store: MatchStore
    @State private var myTeamName = "Moi"
    @State private var opponentTeamName = "Adversaires"

    var body: some View {
        Form {
            Section("Équipes") {
                TextField("Mon équipe", text: $myTeamName)
                TextField("Équipe adverse", text: $opponentTeamName)
            }
            Section {
                Button {
                    store.startMatch(myTeamName: myTeamName, opponentTeamName: opponentTeamName)
                } label: {
                    Label("Commencer le match", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle("Nouveau match")
    }
}

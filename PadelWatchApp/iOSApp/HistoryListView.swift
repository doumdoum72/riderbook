import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var store: MatchStore

    var body: some View {
        NavigationView {
            List(store.matches) { match in
                NavigationLink(destination: MatchDetailView(match: match)) {
                    VStack(alignment: .leading) {
                        Text("\(match.myTeamName) vs \(match.opponentTeamName)")
                            .font(.headline)
                        HStack {
                            Text(match.date, style: .date)
                            Spacer()
                            Text("\(match.faultCount) fautes")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Historique")
            .overlay {
                if store.matches.isEmpty {
                    Text("Aucun match pour l'instant.\nJoue un match depuis ta montre !")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
        }
    }
}

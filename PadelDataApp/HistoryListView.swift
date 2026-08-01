import SwiftUI

struct HistoryListView: View {
    @EnvironmentObject var store: MatchStore

    var body: some View {
        NavigationView {
            List {
                ForEach(store.matches) { match in
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
                .onDelete(perform: store.deleteMatch)
            }
            .navigationTitle("Historique")
            .overlay {
                if store.matches.isEmpty {
                    Text("Aucun match pour l'instant.\nLance-en un depuis l'onglet Match !")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
        }
    }
}

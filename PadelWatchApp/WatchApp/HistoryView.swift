import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var store: MatchStore

    var body: some View {
        List(store.matches) { match in
            NavigationLink(destination: MatchDetailView(match: match)) {
                VStack(alignment: .leading) {
                    Text(match.date, style: .date)
                        .font(.caption)
                    Text("\(match.faultCount) fautes")
                        .font(.body)
                }
            }
        }
        .navigationTitle("Historique")
        .overlay {
            if store.matches.isEmpty {
                Text("Aucun match")
                    .foregroundColor(.secondary)
            }
        }
    }
}

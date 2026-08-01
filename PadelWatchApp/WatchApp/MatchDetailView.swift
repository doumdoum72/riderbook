import SwiftUI

struct MatchDetailView: View {
    let match: Match

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(match.date, style: .date)
                    .font(.caption)
                Text("\(match.myTeamName) vs \(match.opponentTeamName)")
                    .font(.caption2)
                    .foregroundColor(.secondary)

                Divider()

                Text("Fautes: \(match.faultCount)")
                    .font(.headline)

                ForEach(FaultType.allCases) { type in
                    Text("\(type.rawValue): \(match.faultCount(for: type))")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                Divider()

                ForEach(match.sets) { set in
                    Text("Set: \(set.myGames) - \(set.opponentGames)")
                        .font(.caption)
                }
            }
            .padding()
        }
        .navigationTitle("Détail")
    }
}

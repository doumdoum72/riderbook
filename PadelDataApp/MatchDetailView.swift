import SwiftUI

struct MatchDetailView: View {
    let match: Match

    var body: some View {
        List {
            Section("Match") {
                LabeledContent("Date", value: match.date.formatted(date: .abbreviated, time: .shortened))
                LabeledContent("Équipes", value: "\(match.myTeamName) vs \(match.opponentTeamName)")
                LabeledContent("Fautes", value: "\(match.faultCount)")
            }
            Section("Répartition des fautes") {
                ForEach(FaultType.allCases) { type in
                    LabeledContent(type.rawValue, value: "\(match.faultCount(for: type))")
                }
            }
            Section("Sets") {
                ForEach(match.sets) { set in
                    Text("\(set.myGames) - \(set.opponentGames)")
                }
            }
            if !match.faults.isEmpty {
                Section("Chronologie des fautes") {
                    ForEach(match.faults) { fault in
                        HStack {
                            Text(fault.type.rawValue)
                            Spacer()
                            Text(fault.timestamp.formatted(date: .omitted, time: .standard))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Détail du match")
    }
}

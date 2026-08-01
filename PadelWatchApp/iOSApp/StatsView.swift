import SwiftUI
import Charts

struct StatsView: View {
    @EnvironmentObject var store: MatchStore

    private var averageFaults: Double {
        guard !store.matches.isEmpty else { return 0 }
        let total = store.matches.reduce(0) { $0 + $1.faultCount }
        return Double(total) / Double(store.matches.count)
    }

    var body: some View {
        NavigationView {
            List {
                Section("Résumé") {
                    LabeledContent("Matchs joués", value: "\(store.matches.count)")
                    LabeledContent("Moyenne de fautes", value: String(format: "%.1f", averageFaults))
                }
                if !store.matches.isEmpty {
                    Section("Évolution des fautes") {
                        Chart(store.matches.sorted(by: { $0.date < $1.date })) { match in
                            LineMark(
                                x: .value("Date", match.date),
                                y: .value("Fautes", match.faultCount)
                            )
                            PointMark(
                                x: .value("Date", match.date),
                                y: .value("Fautes", match.faultCount)
                            )
                        }
                        .frame(height: 200)
                    }
                }
            }
            .navigationTitle("Statistiques")
        }
    }
}

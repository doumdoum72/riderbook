import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            MatchTabView()
                .tabItem { Label("Match", systemImage: "figure.tennis") }
            HistoryListView()
                .tabItem { Label("Historique", systemImage: "clock.arrow.circlepath") }
            StatsView()
                .tabItem { Label("Statistiques", systemImage: "chart.bar") }
        }
    }
}

private struct MatchTabView: View {
    @EnvironmentObject var store: MatchStore

    var body: some View {
        NavigationView {
            if store.currentMatch != nil {
                LiveMatchView()
            } else {
                StartMatchView()
            }
        }
    }
}

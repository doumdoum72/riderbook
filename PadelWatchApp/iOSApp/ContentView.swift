import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HistoryListView()
                .tabItem { Label("Historique", systemImage: "clock.arrow.circlepath") }
            StatsView()
                .tabItem { Label("Statistiques", systemImage: "chart.bar") }
        }
    }
}

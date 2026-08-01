import SwiftUI

@main
struct PadelWatchAppMain: App {
    @StateObject private var store = MatchStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}

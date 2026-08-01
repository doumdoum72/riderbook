import SwiftUI

@main
struct PadelAppMain: App {
    @StateObject private var store = MatchStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(store)
        }
    }
}

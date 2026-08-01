import SwiftUI

struct RootView: View {
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

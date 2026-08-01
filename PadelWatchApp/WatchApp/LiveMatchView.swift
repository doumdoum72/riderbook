import SwiftUI

struct LiveMatchView: View {
    @EnvironmentObject var store: MatchStore
    @State private var showEndConfirmation = false

    var body: some View {
        ScrollView {
            if let match = store.currentMatch {
                VStack(spacing: 10) {
                    Text("\(match.faultCount)")
                        .font(.system(size: 40, weight: .bold))
                    Text("fautes totales")
                        .font(.caption2)
                        .foregroundColor(.secondary)

                    ForEach(FaultType.allCases) { type in
                        Button {
                            store.addFault(type: type)
                        } label: {
                            HStack {
                                Text(type.rawValue)
                                Spacer()
                                Text("\(match.faultCount(for: type))")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(color(for: type))
                    }

                    Button {
                        store.removeLastFault()
                    } label: {
                        Text("Annuler dernière faute")
                            .font(.caption)
                    }
                    .disabled(match.faults.isEmpty)

                    Divider()

                    if let lastSet = match.sets.last {
                        Text("\(lastSet.myGames) - \(lastSet.opponentGames)")
                            .font(.title2)
                    }

                    HStack {
                        Button {
                            store.addGame(toMe: true)
                        } label: {
                            Text("+1 jeu (moi)")
                        }
                        Button {
                            store.addGame(toMe: false)
                        } label: {
                            Text("+1 jeu (eux)")
                        }
                    }
                    .font(.caption2)

                    Button {
                        store.newSet()
                    } label: {
                        Text("Nouveau set")
                            .font(.caption2)
                    }

                    Button(role: .destructive) {
                        showEndConfirmation = true
                    } label: {
                        Text("Terminer le match")
                    }
                    .padding(.top, 8)
                }
                .padding()
            }
        }
        .navigationTitle("Match")
        .confirmationDialog("Terminer le match ?", isPresented: $showEndConfirmation) {
            Button("Terminer", role: .destructive) { store.endMatch() }
            Button("Annuler", role: .cancel) {}
        }
    }

    private func color(for type: FaultType) -> Color {
        switch type {
        case .mine: return .red
        case .provoked: return .orange
        case .partner: return .yellow
        }
    }
}

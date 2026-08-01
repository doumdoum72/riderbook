import SwiftUI

struct LiveMatchView: View {
    @EnvironmentObject var store: MatchStore
    @State private var showEndConfirmation = false

    var body: some View {
        ScrollView {
            if let match = store.currentMatch {
                VStack(spacing: 20) {
                    VStack {
                        Text("\(match.faultCount)")
                            .font(.system(size: 56, weight: .bold))
                        Text("fautes totales")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 12) {
                        ForEach(FaultType.allCases) { type in
                            Button {
                                store.addFault(type: type)
                            } label: {
                                HStack {
                                    Text(type.rawValue)
                                        .font(.headline)
                                    Spacer()
                                    Text("\(match.faultCount(for: type))")
                                        .font(.title3)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(color(for: type).opacity(0.15))
                                .cornerRadius(12)
                            }
                        }

                        Button(role: .destructive) {
                            store.removeLastFault()
                        } label: {
                            Text("Annuler la dernière faute")
                        }
                        .disabled(match.faults.isEmpty)
                    }

                    Divider()

                    VStack(spacing: 12) {
                        Text("Score")
                            .font(.headline)

                        if let lastSet = match.sets.last {
                            Text("\(lastSet.myGames) - \(lastSet.opponentGames)")
                                .font(.system(size: 40, weight: .semibold))
                        }

                        HStack(spacing: 16) {
                            Button {
                                store.addGame(toMe: true)
                            } label: {
                                Label("+1 jeu (moi)", systemImage: "plus.circle")
                            }
                            Button {
                                store.addGame(toMe: false)
                            } label: {
                                Label("+1 jeu (eux)", systemImage: "plus.circle")
                            }
                        }
                        .buttonStyle(.bordered)

                        Button {
                            store.newSet()
                        } label: {
                            Text("Nouveau set")
                        }
                    }

                    Button(role: .destructive) {
                        showEndConfirmation = true
                    } label: {
                        Text("Terminer le match")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 8)
                }
                .padding()
            }
        }
        .navigationTitle("Match en cours")
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

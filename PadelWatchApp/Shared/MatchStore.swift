import Foundation
import Combine

final class MatchStore: ObservableObject {
    @Published var matches: [Match] = []
    @Published var currentMatch: Match?

    private let fileURL: URL
    private let connectivity = ConnectivityManager.shared

    init() {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        fileURL = dir.appendingPathComponent("padel_matches.json")
        load()
        connectivity.onMatchesReceived = { [weak self] received in
            self?.merge(received)
        }
    }

    func startMatch(myTeamName: String, opponentTeamName: String) {
        currentMatch = Match(
            myTeamName: myTeamName.isEmpty ? "Moi" : myTeamName,
            opponentTeamName: opponentTeamName.isEmpty ? "Adversaires" : opponentTeamName
        )
    }

    func addFault(type: FaultType) {
        guard var match = currentMatch else { return }
        match.faults.append(FaultEvent(timestamp: Date(), type: type))
        currentMatch = match
    }

    func removeLastFault() {
        guard var match = currentMatch, !match.faults.isEmpty else { return }
        match.faults.removeLast()
        currentMatch = match
    }

    func addGame(toMe: Bool) {
        guard var match = currentMatch, !match.sets.isEmpty else { return }
        let lastIndex = match.sets.count - 1
        if toMe {
            match.sets[lastIndex].myGames += 1
        } else {
            match.sets[lastIndex].opponentGames += 1
        }
        currentMatch = match
    }

    func newSet() {
        guard var match = currentMatch else { return }
        match.sets.append(SetScore())
        currentMatch = match
    }

    func endMatch() {
        guard var match = currentMatch else { return }
        match.isFinished = true
        matches.insert(match, at: 0)
        currentMatch = nil
        save()
        connectivity.send(matches: matches)
    }

    func cancelMatch() {
        currentMatch = nil
    }

    private func merge(_ received: [Match]) {
        var byID = Dictionary(uniqueKeysWithValues: matches.map { ($0.id, $0) })
        for match in received {
            byID[match.id] = match
        }
        matches = byID.values.sorted { $0.date > $1.date }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        matches = (try? JSONDecoder().decode([Match].self, from: data)) ?? []
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(matches) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}

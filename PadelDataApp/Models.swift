import Foundation

enum FaultType: String, Codable, CaseIterable, Identifiable {
    case mine = "Ma faute"
    case provoked = "Faute provoquée"
    case partner = "Faute partenaire"

    var id: String { rawValue }
}

struct FaultEvent: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var timestamp: Date = Date()
    var type: FaultType = .mine
}

struct SetScore: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var myGames: Int = 0
    var opponentGames: Int = 0
}

struct Match: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var date: Date = Date()
    var myTeamName: String = "Moi"
    var opponentTeamName: String = "Adversaires"
    var sets: [SetScore] = [SetScore()]
    var faults: [FaultEvent] = []
    var isFinished: Bool = false

    var faultCount: Int { faults.count }

    func faultCount(for type: FaultType) -> Int {
        faults.filter { $0.type == type }.count
    }
}

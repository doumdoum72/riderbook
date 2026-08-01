import Foundation
import WatchConnectivity

final class ConnectivityManager: NSObject, WCSessionDelegate {
    static let shared = ConnectivityManager()

    var onMatchesReceived: (([Match]) -> Void)?

    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func send(matches: [Match]) {
        guard WCSession.isSupported(), WCSession.default.activationState == .activated else { return }
        guard let data = try? JSONEncoder().encode(matches) else { return }
        try? WCSession.default.updateApplicationContext(["matches": data])
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        guard let data = applicationContext["matches"] as? Data,
              let matches = try? JSONDecoder().decode([Match].self, from: data) else { return }
        DispatchQueue.main.async {
            self.onMatchesReceived?(matches)
        }
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    #endif
}

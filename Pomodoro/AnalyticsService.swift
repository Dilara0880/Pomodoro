import Foundation

final class AnalyticsService {

    private let key = "crash_free_sessions"

    func recordSession() {
        let value = UserDefaults.standard.integer(forKey: key)
        UserDefaults.standard.set(value + 1, forKey: key)
    }

    func sessionsCount() -> Int {
        UserDefaults.standard.integer(forKey: key)
    }
}

import Foundation
import Combine

final class TimerService {
    private var timer: AnyCancellable?

    func start(action: @escaping () -> Void) {
        action()
        
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in action() }
    }

    func stop() {
        timer?.cancel()
        timer = nil
    }
}

import XCTest
@testable import Pomodoro

final class TimerServiceTests: XCTestCase {

    func testTimerFires() {
        let expectation = XCTestExpectation(description: "Timer tick")

        let timerService = TimerService()
        var tickCount = 0

        timerService.start {
            tickCount += 1
            if tickCount == 2 {
                expectation.fulfill()
                timerService.stop()
            }
        }

        wait(for: [expectation], timeout: 3)
        XCTAssertGreaterThanOrEqual(tickCount, 2)
    }
}

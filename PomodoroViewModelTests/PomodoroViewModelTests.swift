import XCTest
@testable import Pomodoro

final class PomodoroViewModelFunctionalTests: XCTestCase {

    var vm: PomodoroViewModel!

    override func setUp() {
        super.setUp()
        vm = PomodoroViewModel()
    }

    func testTimerStartAndPause() {
        vm.start()
        XCTAssertTrue(vm.isRunning)

        vm.pause()
        XCTAssertFalse(vm.isRunning)
    }

    func testTimerReset() {
        vm.timeRemaining = 100
        vm.reset()
        XCTAssertEqual(vm.timeRemaining, vm.workDurationSeconds)
        XCTAssertEqual(vm.mode, .work)
    }

    func testSwitchModeAndCompletedPomodoros() {
        vm.timeRemaining = 0
        vm.switchMode()
        XCTAssertEqual(vm.mode, .rest)
        XCTAssertEqual(vm.completedPomodoros, 1)
    }

    func testSettingsUpdateTime() {
        let oldWork = vm.workDurationSeconds
        vm.workDurationMinutes = 10
        XCTAssertEqual(vm.workDurationSeconds, 600)
        XCTAssertNotEqual(vm.workDurationSeconds, oldWork)
    }
}

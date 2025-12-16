import XCTest
@testable import Pomodoro

final class PomodoroViewModelTests: XCTestCase {

    var vm: PomodoroViewModel!

    override func setUp() async throws {
        try await super.setUp()
        vm = await PomodoroViewModel()
    }

    @MainActor
    func testStartTimer() {
        vm.start()
        XCTAssertTrue(vm.isRunning)
    }

    @MainActor
    func testPauseTimer() {
        vm.start()
        vm.pause()
        XCTAssertFalse(vm.isRunning)
    }

    @MainActor
    func testResetTimer() {
        vm.timeRemaining = 10
        vm.reset()

        XCTAssertEqual(vm.timeRemaining, 25 * 60)
        XCTAssertEqual(vm.mode, .work)
    }

    @MainActor
    func testSwitchModeAndPomodoroCount() {
        vm.timeRemaining = 0
        vm.switchMode()

        XCTAssertEqual(vm.mode, .rest)
        XCTAssertEqual(vm.completedPomodoros, 1)
    }
}

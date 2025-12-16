import XCTest
@testable import Pomodoro

@MainActor
final class PomodoroViewModelTests: XCTestCase {

    var vm: PomodoroViewModel!

    override func setUp() {
        super.setUp()
        vm = PomodoroViewModel(
            session: PomodoroSession(
                workDuration: 2,
                breakDuration: 1,
                completedPomodoros: 0
            )
        )
    }

    override func tearDown() {
        vm = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(vm.mode, .work)
        XCTAssertFalse(vm.isRunning)
        XCTAssertEqual(vm.completedPomodoros, 0)
        XCTAssertEqual(vm.treeState, .start)
    }

    func testStartTimer() {
        vm.start()

        XCTAssertTrue(vm.isRunning)
        XCTAssertEqual(vm.treeState, .growing)
    }

    func testPauseTimer() {
        vm.start()
        vm.pause()

        XCTAssertFalse(vm.isRunning)
    }

    func testResetTimer() {
        vm.start()
        vm.reset()

        XCTAssertFalse(vm.isRunning)
        XCTAssertEqual(vm.mode, .work)
        XCTAssertEqual(vm.treeState, .start)
    }

    func testSwitchFromWorkToRest() {
        vm.switchMode()

        XCTAssertEqual(vm.mode, .rest)
        XCTAssertEqual(vm.completedPomodoros, 1)
        XCTAssertEqual(vm.treeState, .fruits)
    }

    func testFeedbackShownOnlyEverySecondSession() {
        vm.switchMode()
        XCTAssertFalse(vm.showFeedbackPrompt)

        vm.mode = .work
        vm.switchMode()
        XCTAssertTrue(vm.showFeedbackPrompt)
    }
}

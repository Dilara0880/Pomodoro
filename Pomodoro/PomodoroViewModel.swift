import Foundation
import Combine

final class PomodoroViewModel: ObservableObject {
    enum Mode { case work, rest }
    enum TreeState { case start, growing, fruits }

    @Published var timeRemaining: Int = 0
    @Published var isRunning = false
    @Published var mode: Mode = .work
    @Published var completedPomodoros: Int = 0
    @Published var treeState: TreeState = .start

    @Published var workDurationSeconds: Int
    @Published var breakDurationSeconds: Int
    @Published var showFeedbackPrompt = false


    @Published var workDurationMinutes: Int {
        didSet {
            workDurationSeconds = workDurationMinutes * 60
            if !isRunning && mode == .work {
                timeRemaining = workDurationSeconds
            }
        }
    }

    @Published var breakDurationMinutes: Int {
        didSet {
            breakDurationSeconds = breakDurationMinutes * 60
            if !isRunning && mode == .rest {
                timeRemaining = breakDurationSeconds
            }
        }
    }


    private let timerService = TimerService()
    private let notificationService = NotificationService()
    private let endDateKey = "pomodoroEndDate"
    let analyticsService = AnalyticsService()

    init(session: PomodoroSession = PomodoroSession()) {
        self.workDurationSeconds = session.workDuration
        self.breakDurationSeconds = session.breakDuration
        self.workDurationMinutes = session.workDuration / 60
        self.breakDurationMinutes = session.breakDuration / 60
        self.timeRemaining = workDurationSeconds
        self.completedPomodoros = session.completedPomodoros
        self.treeState = .start
        notificationService.requestPermission()
    }

    func start() {
        guard !isRunning else { return }
        isRunning = true
        treeState = .growing // Начало сессии
        saveEndDate()
        timerService.start { [weak self] in
            self?.tick()
        }
    }

    func pause() {
        isRunning = false
        timerService.stop()
    }

    func reset() {
        pause()
        mode = .work
        timeRemaining = workDurationSeconds
        treeState = .start // Возвращаем картинку StartTree
    }

    private func tick() {
        if let endDate = UserDefaults.standard.object(forKey: endDateKey) as? Date {
            let remaining = max(0, Int(endDate.timeIntervalSinceNow))
            timeRemaining = remaining
            if remaining <= 0 { switchMode() }
        }
    }

    func switchMode() {
        pause()
        
        if mode == .work {
                completedPomodoros += 1
                analyticsService.recordSession()
            if completedPomodoros % 2 == 0{
                showFeedbackPrompt = true
            }
                notificationService.send(
                    title: "Pomodoro finished",
                    body: "Time to rest"
                )

                mode = .rest
                timeRemaining = breakDurationSeconds
                treeState = .fruits
        } else {
            notificationService.send(
                title: "Break finished",
                body: "Time to focus"
            )

            mode = .work
            timeRemaining = workDurationSeconds
            treeState = .start
        }
            
        
        if isRunning {
            saveEndDate()
            start()
        }

    }
    

    private func saveEndDate() {
        let endDate = Date().addingTimeInterval(TimeInterval(timeRemaining))
        UserDefaults.standard.set(endDate, forKey: endDateKey)
    }
    
    func restoreIfNeeded() {
        guard let endDate = UserDefaults.standard.object(forKey: endDateKey) as? Date else { return }
        let remaining = Int(endDate.timeIntervalSinceNow)
        if remaining > 0 {
            timeRemaining = remaining
            isRunning = true
            timerService.start { [weak self] in
                self?.tick()
            }
        }
    }

}


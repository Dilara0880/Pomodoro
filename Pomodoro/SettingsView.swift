import SwiftUI


struct SettingsView: View {
    @ObservedObject var vm: PomodoroViewModel

    var body: some View {
        Form {
            Stepper("Work: \(vm.workDurationMinutes) min",
                    value: Binding(
                        get: { vm.workDurationMinutes },
                        set: { vm.workDurationMinutes = $0 }
                    ),
                    in: 1...60,
                    step: 5)

            Stepper("Break: \(vm.breakDurationMinutes) min",
                    value: Binding(
                        get: { vm.breakDurationMinutes },
                        set: { vm.breakDurationMinutes = $0 }
                    ),
                    in: 1...30,
                    step: 1)
        }
    }
}


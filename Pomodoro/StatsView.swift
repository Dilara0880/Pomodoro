import SwiftUI

struct StatsView: View {
    @ObservedObject var vm: PomodoroViewModel

    var body: some View {
        VStack {
            Text("Completed Pomodoros")
                .font(.title2)
            Text("\(vm.completedPomodoros)")
                .font(.system(size: 40, weight: .bold))
        }
    }
}

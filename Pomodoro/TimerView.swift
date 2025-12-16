import SwiftUI

struct TimerView: View {
    @ObservedObject var vm: PomodoroViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text(vm.mode == .work ? "Work" : "Break")
                .font(.largeTitle)

            Image(treeImageName())
                .resizable()
                .scaledToFit()
                .frame(height: 200)

            Text(format(vm.timeRemaining))
                .font(.system(size: 48, weight: .bold))

            HStack {
                Button(vm.isRunning ? "Pause" : "Start") {
                    vm.isRunning ? vm.pause() : vm.start()
                }
                .buttonStyle(.borderedProminent)

                Button("Reset") {
                    vm.reset()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .alert("Rate your focus session",
               isPresented: $vm.showFeedbackPrompt) {
            Button("👍") {}
            Button("👎") {}
        }

    }

    private func format(_ seconds: Int) -> String {
        String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }

    private func treeImageName() -> String {
        switch vm.treeState {
        case .start: return "StartTree"
        case .growing: return "TreeGrowing"
        case .fruits: return "TreeFruits"
        }
    }
}

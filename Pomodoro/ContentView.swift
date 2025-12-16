import SwiftUI

struct ContentView: View {
    @StateObject private var vm = PomodoroViewModel()

    var body: some View {
        TabView {
            TimerView(vm: vm)
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }

            StatsView(vm: vm)
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }

            SettingsView(vm: vm)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            vm.restoreIfNeeded()
        }
    }
}



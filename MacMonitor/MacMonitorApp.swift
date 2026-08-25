import SwiftUI

@main
struct MacMonitorApp: App {

    @StateObject private var themeManager =
        ThemeManager()

    var body: some Scene {

        // MARK: - Main Window

        WindowGroup {

            MainView()
                .environmentObject(
                    themeManager
                )
                .preferredColorScheme(
                    themeManager.colorScheme
                )
        }

        // MARK: - Menu Bar

        MenuBarExtra {

            MenuBarView()

        } label: {

            Image(
                systemName:
                    "gauge.with.dots.needle.bottom.50percent"
            )
        }
        .menuBarExtraStyle(.window)
    }
}

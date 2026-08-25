//
//  AppTheme.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import SwiftUI
import Combine

enum AppTheme: String, CaseIterable, Identifiable {

    case system
    case light
    case dark
    case custom

    var id: String {
        rawValue
    }

    var title: String {

        switch self {

        case .system:
            return "System"

        case .light:
            return "Light"

        case .dark:
            return "Dark"

        case .custom:
            return "Custom"
        }
    }

    var icon: String {

        switch self {

        case .system:
            return "gear"

        case .light:
            return "sun.max"

        case .dark:
            return "moon"

        case .custom:
            return "paintpalette"
        }
    }
}

@MainActor
final class ThemeManager: ObservableObject {

    @Published var theme: AppTheme {
        didSet {
            save()
        }
    }

    @Published var accentColor: Color {
        didSet {
            saveColor()
        }
    }

    init() {

        let savedTheme =
            UserDefaults.standard.string(
                forKey: "macmonitor_theme"
            )

        theme =
            AppTheme(
                rawValue: savedTheme ?? "system"
            ) ?? .system

        accentColor = .blue
    }

    // MARK: - Color Scheme

    var colorScheme: ColorScheme? {

        switch theme {

        case .system:
            return nil

        case .light:
            return .light

        case .dark:
            return .dark

        case .custom:
            return nil
        }
    }

    // MARK: - Persistence

    private func save() {

        UserDefaults.standard.set(
            theme.rawValue,
            forKey: "macmonitor_theme"
        )
    }

    private func saveColor() {

        let resolvedColor =
            NSColor(accentColor)

        if let data = try? NSKeyedArchiver.archivedData(
            withRootObject: resolvedColor,
            requiringSecureCoding: false
        ) {

            UserDefaults.standard.set(
                data,
                forKey: "macmonitor_accent_color"
            )
        }
    }
}
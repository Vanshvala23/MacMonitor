//
//  SettingsView.swift
//  MacMonitor
//
//  Created by Vansh Vala on 26/08/26.
//


import SwiftUI

struct SettingsView: View {

    @EnvironmentObject
    private var themeManager: ThemeManager

    var body: some View {

        Form {

            // MARK: - Appearance

            Section {

                Picker(
                    "Theme",
                    selection: $themeManager.theme
                ) {

                    ForEach(
                        AppTheme.allCases
                    ) { theme in

                        Label(
                            theme.title,
                            systemImage: theme.icon
                        )
                        .tag(theme)
                    }
                }

                if themeManager.theme == .custom {

                    ColorPicker(
                        "Accent Color",
                        selection:
                            $themeManager.accentColor
                    )
                }

            } header: {

                Text("Appearance")

            } footer: {

                Text(
                    "Choose how MacMonitor looks."
                )
            }

            // MARK: - General

            Section("General") {

                Toggle(
                    "Launch MacMonitor at login",
                    isOn: .constant(false)
                )
            }

            // MARK: - About

            Section("About") {

                HStack {

                    Text("Version")

                    Spacer()

                    Text("1.0")
                        .foregroundStyle(
                            .secondary
                        )
                }

                HStack {

                    Text("MacMonitor")

                    Spacer()

                    Text("System Monitor")
                        .foregroundStyle(
                            .secondary
                        )
                }
            }
        }
        .formStyle(.grouped)
        .padding(20)
        .frame(
            maxWidth: 700
        )
    }
}

#Preview {

    SettingsView()
        .environmentObject(
            ThemeManager()
        )
        .frame(
            width: 800,
            height: 600
        )
}
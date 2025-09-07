//
//  SettingsView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var currentUser: User
    @ObservedObject var themeManager: AnimeThemeManager
    @State private var showingUserSelection = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                themeManager.currentTheme.primaryGradient
                    .ignoresSafeArea()
                    .opacity(0.1)

                List {
                    Section(header: Text("🎨 Appearance").font(.headline)) {
                        Toggle("🌙 Dark Mode", isOn: $themeManager.isDarkMode)
                            .toggleStyle(SwitchToggleStyle())
                            .onChange(of: themeManager.isDarkMode) { _ in
                                HapticManager.shared.themeChanged()
                            }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("🌈 Theme")
                                .font(.headline)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(AnimeThemeManager.AnimeTheme.allCases, id: \.self) { theme in
                                        Button(action: {
                                            HapticManager.shared.themeChanged()
                                            themeManager.currentTheme = theme
                                        }) {
                                            VStack(spacing: 4) {
                                                Text(theme.emoji)
                                                    .font(.system(size: 30))

                                                Text(theme.rawValue)
                                                    .font(.caption)
                                                    .foregroundColor(.primary)
                                            }
                                            .padding(12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(theme.primaryGradient)
                                                    .opacity(themeManager.currentTheme == theme ? 1.0 : 0.3)
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(theme.accentColor, lineWidth: themeManager.currentTheme == theme ? 3 : 1)
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }

                    Section(header: Text("👤 Account").font(.headline)) {
                        HStack {
                            Text("Current User")
                            Spacer()
                            Text(currentUser.displayName)
                                .foregroundColor(.secondary)
                        }

                        Button("🔄 Switch User") {
                            HapticManager.shared.buttonTap()
                            showingUserSelection = true
                        }
                        .foregroundColor(themeManager.currentTheme.accentColor)
                    }

                    Section(header: Text("ℹ️ About").font(.headline)) {
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Text("Build")
                            Spacer()
                            Text("1")
                                .foregroundColor(.secondary)
                        }

                        HStack {
                            Text("Made with")
                            Spacer()
                            Text("💖✨")
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("nFactorial School")
                            Spacer()
                            Text("Almaty, Kazakhstan 🇰🇿")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("⚙️ Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingUserSelection) {
            UserSelectionView(selectedUser: $currentUser, themeManager: themeManager)
        }
    }
}

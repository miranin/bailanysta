//
//  AnimeEditProfileView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeEditProfileView: View {
    let user: User
    @ObservedObject var themeManager: AnimeThemeManager
    let onSave: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var bio: String

    init(user: User, themeManager: AnimeThemeManager, onSave: @escaping (String) -> Void) {
        self.user = user
        self.themeManager = themeManager
        self.onSave = onSave
        self._bio = State(initialValue: user.bio ?? "")
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                themeManager.currentTheme.primaryGradient
                    .ignoresSafeArea()
                    .opacity(0.1)

                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("✨ Bio")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        TextField("Tell us about yourself... 💭", text: $bio, axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(.systemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(themeManager.currentTheme.accentColor.opacity(0.3), lineWidth: 2)
                                    )
                            )
                            .lineLimit(3...6)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("✏️ Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.secondary)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save ✨") {
                        onSave(bio)
                    }
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.currentTheme.accentColor)
                }
            }
        }
    }
}

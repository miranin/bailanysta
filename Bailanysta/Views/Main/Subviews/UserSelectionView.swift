//
//  UserSelectionView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct UserSelectionView: View {
    @Binding var selectedUser: User
    @ObservedObject var themeManager: AnimeThemeManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                themeManager.currentTheme.primaryGradient
                    .ignoresSafeArea()
                    .opacity(0.1)

                List {
                    ForEach(User.sampleUsers) { user in
                        Button(action: {
                            selectedUser = user
                            dismiss()
                        }) {
                            HStack {
                                AnimeAvatarGenerator.generateAvatar(for: user, theme: themeManager.currentTheme)
                                    .frame(width: 50, height: 50)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.displayName)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text("@\(user.username)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                if selectedUser.id == user.id {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(themeManager.currentTheme.accentColor)
                                        .font(.title2)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("👥 Select User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done ✨") {
                        dismiss()
                    }
                    .foregroundColor(themeManager.currentTheme.accentColor)
                }
            }
        }
    }
}

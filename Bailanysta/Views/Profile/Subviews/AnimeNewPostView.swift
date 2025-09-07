//
//  AnimeNewPostView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeNewPostView: View {
    @Binding var content: String
    @ObservedObject var themeManager: AnimeThemeManager
    let onCreatePost: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                themeManager.currentTheme.primaryGradient
                    .ignoresSafeArea()
                    .opacity(0.1)

                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What's on your mind? 💭")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        TextField("Share your thoughts with the world! ✨", text: $content, axis: .vertical)
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
                            .lineLimit(5...10)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("📝 New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        content = ""
                        dismiss()
                    }
                    .foregroundColor(.secondary)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post ✨") {
                        onCreatePost()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.currentTheme.accentColor)
                    .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
                }
            }
        }
    }
}

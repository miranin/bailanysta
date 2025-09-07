//
//  AnimeCommentSheetView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeCommentSheetView: View {
    let post: Post
    @ObservedObject var presenter: FeedPresenter
    @ObservedObject var themeManager: AnimeThemeManager
    @Environment(\.dismiss) private var dismiss
    @State private var commentText = ""

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                themeManager.currentTheme.primaryGradient
                    .ignoresSafeArea()
                    .opacity(0.1)

                VStack(spacing: 0) {
                    // Post content
                    AnimePostCardView(
                        post: post,
                        currentUser: presenter.currentUser,
                        themeManager: themeManager,
                        onLike: { presenter.likePost(post) },
                        onComment: {}
                    )
                    .padding()

                    Divider()
                        .background(themeManager.currentTheme.accentColor.opacity(0.3))

                    // Comments list
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(post.comments) { comment in
                                AnimeCommentView(comment: comment, themeManager: themeManager)
                            }
                        }
                        .padding()
                    }

                    // Add comment
                    VStack(spacing: 12) {
                        Divider()
                            .background(themeManager.currentTheme.accentColor.opacity(0.3))

                        HStack(spacing: 12) {
                            TextField("Add a comment... 💬", text: $commentText, axis: .vertical)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(12)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(.systemBackground))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(themeManager.currentTheme.accentColor.opacity(0.3), lineWidth: 1)
                                        )
                                )
                                .lineLimit(1...4)

                            Button(action: {
                                presenter.addComment(to: post, content: commentText)
                                commentText = ""
                            }) {
                                Text("Post ✨")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(themeManager.currentTheme.primaryGradient)
                                    )
                            }
                            .disabled(commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                            .opacity(commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("💬 Comments")
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

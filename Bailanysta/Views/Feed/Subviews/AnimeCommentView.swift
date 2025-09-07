//
//  AnimeCommentView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeCommentView: View {
    let comment: Comment
    @ObservedObject var themeManager: AnimeThemeManager

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AnimeAvatarGenerator.generateAvatar(for: comment.author, theme: themeManager.currentTheme)
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(comment.author.displayName)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Spacer()

                    Text(comment.timestamp, style: .relative)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                Text(comment.content)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineSpacing(2)
            }

            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: themeManager.currentTheme.accentColor.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(themeManager.currentTheme.accentColor.opacity(0.2), lineWidth: 1)
        )
    }
}

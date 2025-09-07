//
//  AnimeUserPostCardView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeUserPostCardView: View {
    let post: Post
    @ObservedObject var themeManager: AnimeThemeManager
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                HStack(spacing: 6) {
                    Text("📅")
                        .font(.caption)
                    Text(post.timestamp, style: .relative)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button(action: onDelete) {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                        Text("Delete")
                    }
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red.opacity(0.1))
                    )
                }
            }

            Text(post.content)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)

            HStack(spacing: 20) {
                HStack(spacing: 6) {
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                    Text("\(post.likes)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 6) {
                    Image(systemName: "message")
                        .foregroundColor(themeManager.currentTheme.accentColor)
                    Text("\(post.comments.count)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text(AnimeEmojis.reactions.randomElement() ?? "✨")
                    .font(.title3)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: themeManager.currentTheme.accentColor.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(themeManager.currentTheme.accentColor.opacity(0.3), lineWidth: 2)
        )
    }
}

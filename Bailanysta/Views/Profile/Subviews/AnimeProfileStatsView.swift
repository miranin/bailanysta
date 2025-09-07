//
//  AnimeProfileStatsView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeProfileStatsView: View {
    let postsCount: Int
    @ObservedObject var themeManager: AnimeThemeManager

    var body: some View {
        HStack(spacing: 32) {
            VStack(spacing: 4) {
                Text("\(postsCount)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.currentTheme.accentColor)
                Text("Posts 📝")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }

            VStack(spacing: 4) {
                Text("0")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.currentTheme.accentColor)
                Text("Following 👥")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }

            VStack(spacing: 4) {
                Text("0")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.currentTheme.accentColor)
                Text("Followers 💖")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: themeManager.currentTheme.accentColor.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(themeManager.currentTheme.accentColor.opacity(0.3), lineWidth: 2)
        )
        .padding(.horizontal)
    }
}

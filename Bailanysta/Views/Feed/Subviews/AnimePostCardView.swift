//
//  AnimePostCardView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimePostCardView: View {
    let post: Post
    let currentUser: User
    @ObservedObject var themeManager: AnimeThemeManager
    let onLike: () -> Void
    let onComment: () -> Void
    @State private var showParticles = false
    @State private var particles: [Particle] = []
    
    private var isLiked: Bool {
        post.isLikedBy(currentUser)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Author info
            HStack {
                AnimeAvatarGenerator.generateAvatar(for: post.author, theme: themeManager.currentTheme)
                    .frame(width: 50, height: 50)

                VStack(alignment: .leading, spacing: 4) {
                    Text(post.author.displayName)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Text("@\(post.author.username)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(post.timestamp, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✨")
                        .font(.caption)
                }
            }

            // Post content
            Text(post.content)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)

            // Actions
            HStack(spacing: 24) {
                Button(action: {
                    HapticManager.shared.like()
                    onLike()
                    // Trigger particle effect
                    triggerLikeParticles()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : themeManager.currentTheme.accentColor)
                            .scaleEffect(isLiked ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isLiked)

                        Text("\(post.likes)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    HapticManager.shared.comment()
                    onComment()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "message")
                            .foregroundColor(themeManager.currentTheme.accentColor)

                        Text("\(post.comments.count)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
                .buttonStyle(PlainButtonStyle())

                Spacer()

                Text(AnimeEmojis.reactions.randomElement() ?? "✨")
                    .font(.title2)
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
        .overlay(
            // Particle effects overlay
            ZStack {
                if showParticles {
                    ParticleEffectView(particles: particles)
                        .allowsHitTesting(false)
                }
            }
        )
    }
    
    private func triggerLikeParticles() {
        let center = CGPoint(x: 0, y: 0) // Center of the like button
        particles = ParticleGenerator.generateLikeParticles(center: center, theme: themeManager.currentTheme)
        showParticles = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showParticles = false
        }
    }
}

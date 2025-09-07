//
//  AnimeLoadingView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeLoadingView: View {
    @ObservedObject var themeManager: AnimeThemeManager
    let message: String
    @State private var isAnimating = false
    @State private var rotationAngle: Double = 0
    @State private var scale: CGFloat = 1.0
    
    init(themeManager: AnimeThemeManager, message: String = "Loading... ✨") {
        self.themeManager = themeManager
        self.message = message
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Animated character
            ZStack {
                // Outer glow ring
                Circle()
                    .stroke(themeManager.currentTheme.accentColor, lineWidth: 3)
                    .frame(width: 100, height: 100)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .opacity(isAnimating ? 0.3 : 0.8)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                
                // Main character circle
                Circle()
                    .fill(themeManager.currentTheme.primaryGradient)
                    .frame(width: 80, height: 80)
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: scale)
                
                // Character emoji
                Text("🌸")
                    .font(.system(size: 40))
                    .rotationEffect(.degrees(rotationAngle))
                    .animation(.linear(duration: 2.0).repeatForever(autoreverses: false), value: rotationAngle)
            }
            
            // Loading text with animation
            VStack(spacing: 8) {
                Text(message)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .opacity(isAnimating ? 0.5 : 1.0)
                    .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
                
                // Dots animation
                HStack(spacing: 4) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(themeManager.currentTheme.accentColor)
                            .frame(width: 8, height: 8)
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .animation(
                                .easeInOut(duration: 0.6)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2),
                                value: isAnimating
                            )
                    }
                }
            }
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        isAnimating = true
        rotationAngle = 360
        scale = 1.1
    }
}

// MARK: - Specific Loading Views

struct FeedLoadingView: View {
    @ObservedObject var themeManager: AnimeThemeManager
    
    var body: some View {
        VStack(spacing: 20) {
            AnimeLoadingView(themeManager: themeManager, message: "Loading posts... ✨")
            
            HStack(spacing: 12) {
                ForEach(0..<5, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(themeManager.currentTheme.accentColor.opacity(0.3))
                        .frame(width: 60, height: 80)
                        .animation(
                            .easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.1),
                            value: themeManager.currentTheme.accentColor
                        )
                }
            }
        }
    }
}

struct ProfileLoadingView: View {
    @ObservedObject var themeManager: AnimeThemeManager
    
    var body: some View {
        VStack(spacing: 20) {
            AnimeLoadingView(themeManager: themeManager, message: "Loading profile... ✨")
            
            // Profile skeleton
            VStack(spacing: 16) {
                // Avatar skeleton
                Circle()
                    .fill(themeManager.currentTheme.accentColor.opacity(0.3))
                    .frame(width: 80, height: 80)
                
                // Name skeleton
                RoundedRectangle(cornerRadius: 8)
                    .fill(themeManager.currentTheme.accentColor.opacity(0.3))
                    .frame(width: 120, height: 20)
                
                // Bio skeleton
                RoundedRectangle(cornerRadius: 8)
                    .fill(themeManager.currentTheme.accentColor.opacity(0.3))
                    .frame(width: 200, height: 16)
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        AnimeLoadingView(themeManager: AnimeThemeManager())
        FeedLoadingView(themeManager: AnimeThemeManager())
        ProfileLoadingView(themeManager: AnimeThemeManager())
    }
    .padding()
}

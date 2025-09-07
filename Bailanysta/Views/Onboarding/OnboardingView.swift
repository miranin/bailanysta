//
//  OnboardingView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var themeManager: AnimeThemeManager
    @State private var currentPage = 0
    @State private var showMainApp = false
    @State private var isAnimating = false
    
    let pages = [
        OnboardingPage(
            emoji: "🌸",
            title: "Welcome to Bailanysta",
            description: "Your anime-themed social media experience awaits!",
            color: .pink
        ),
        OnboardingPage(
            emoji: "💖",
            title: "Connect & Share",
            description: "Share your thoughts, like posts, and comment with friends!",
            color: .red
        ),
        OnboardingPage(
            emoji: "✨",
            title: "Beautiful Themes",
            description: "Choose from 6 stunning anime themes to personalize your experience!",
            color: .purple
        ),
        OnboardingPage(
            emoji: "🚀",
            title: "Ready to Start?",
            description: "Let's begin your anime social media journey!",
            color: .blue
        )
    ]
    
    var body: some View {
        ZStack {
            // Background gradient
            themeManager.currentTheme.primaryGradient
                .ignoresSafeArea()
                .opacity(0.1)
            
            VStack(spacing: 0) {
                // Page content
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(
                            page: pages[index],
                            themeManager: themeManager,
                            isAnimating: isAnimating
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)
                
                // Bottom section
                VStack(spacing: 24) {
                    // Page indicators
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? themeManager.currentTheme.accentColor : Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .scaleEffect(index == currentPage ? 1.2 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: currentPage)
                        }
                    }
                    
                    // Action buttons
                    HStack(spacing: 16) {
                        if currentPage > 0 {
                            Button("Previous") {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    currentPage -= 1
                                }
                                HapticManager.shared.buttonTap()
                            }
                            .foregroundColor(themeManager.currentTheme.accentColor)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(themeManager.currentTheme.accentColor, lineWidth: 2)
                            )
                        }
                        
                        Spacer()
                        
                        Button(currentPage == pages.count - 1 ? "Get Started ✨" : "Next") {
                            if currentPage == pages.count - 1 {
                                // Mark onboarding as completed
                                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                                
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showMainApp = true
                                }
                                HapticManager.shared.postCreated()
                            } else {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                    currentPage += 1
                                }
                                HapticManager.shared.buttonTap()
                            }
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(themeManager.currentTheme.primaryGradient)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(themeManager.currentTheme.accentColor, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal, 32)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
        .fullScreenCover(isPresented: $showMainApp) {
            MainTabView()
        }
    }
}

struct OnboardingPage {
    let emoji: String
    let title: String
    let description: String
    let color: Color
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    @ObservedObject var themeManager: AnimeThemeManager
    let isAnimating: Bool
    @State private var emojiScale: CGFloat = 1.0
    @State private var titleOffset: CGFloat = 50
    @State private var descriptionOffset: CGFloat = 30
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Emoji with animation
            Text(page.emoji)
                .font(.system(size: 120))
                .scaleEffect(emojiScale)
                .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: emojiScale)
            
            // Title
            Text(page.title)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .offset(y: titleOffset)
                .animation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.2), value: titleOffset)
            
            // Description
            Text(page.description)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .offset(y: descriptionOffset)
                .animation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.4), value: descriptionOffset)
            
            Spacer()
        }
        .padding(.horizontal, 32)
        .onAppear {
            emojiScale = 1.1
            titleOffset = 0
            descriptionOffset = 0
        }
    }
}

#Preview {
    OnboardingView(themeManager: AnimeThemeManager())
}

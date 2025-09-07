//
//  SplashView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isAnimating = false
    @State private var showMainApp = false
    @State private var particleOffset: CGFloat = 0
    @State private var rotationAngle: Double = 0
    @ObservedObject var themeManager: AnimeThemeManager
    
    init(themeManager: AnimeThemeManager) {
        self.themeManager = themeManager
    }
    
    var body: some View {
        ZStack {
            // Animated background gradient
            themeManager.currentTheme.primaryGradient
                .ignoresSafeArea()
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: isAnimating)
            
            // Floating particles
            ForEach(0..<20, id: \.self) { index in
                Circle()
                    .fill(themeManager.currentTheme.accentColor.opacity(0.6))
                    .frame(width: CGFloat.random(in: 4...12))
                    .offset(
                        x: CGFloat.random(in: -200...200),
                        y: particleOffset + CGFloat.random(in: -100...100)
                    )
                    .animation(
                        .easeInOut(duration: Double.random(in: 2...4))
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.1),
                        value: particleOffset
                    )
            }
            
            VStack(spacing: 30) {
                // Animated app icon
                ZStack {
                    // Outer glow ring
                    Circle()
                        .stroke(themeManager.currentTheme.accentColor, lineWidth: 4)
                        .frame(width: 120, height: 120)
                        .scaleEffect(isAnimating ? 1.2 : 1.0)
                        .opacity(isAnimating ? 0.3 : 0.8)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                    
                    // Main icon
                    ZStack {
                        Circle()
                            .fill(themeManager.currentTheme.primaryGradient)
                            .frame(width: 100, height: 100)
                        
                        Text("🌸")
                            .font(.system(size: 50))
                            .rotationEffect(.degrees(rotationAngle))
                            .animation(.linear(duration: 3.0).repeatForever(autoreverses: false), value: rotationAngle)
                    }
                }
                
                // App title with animation
                VStack(spacing: 8) {
                    Text("Bailanysta")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                        .scaleEffect(isAnimating ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
                    
                    Text("Anime Social Media ✨")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0.5, y: 0.5)
                }
                
                // Loading indicator
                VStack(spacing: 12) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                    
                    Text("Loading...")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
        }
        .onAppear {
            startAnimations()
            
            // Show main app after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showMainApp = true
                }
            }
        }
        .fullScreenCover(isPresented: $showMainApp) {
            // Check if user has seen onboarding
            if UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
                MainTabView()
            } else {
                OnboardingView(themeManager: themeManager)
            }
        }
    }
    
    private func startAnimations() {
        isAnimating = true
        particleOffset = -200
        rotationAngle = 360
    }
}

#Preview {
    SplashView(themeManager: AnimeThemeManager())
}

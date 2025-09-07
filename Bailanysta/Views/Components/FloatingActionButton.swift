//
//  FloatingActionButton.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct FloatingActionButton: View {
    @ObservedObject var themeManager: AnimeThemeManager
    let action: () -> Void
    @State private var isPressed = false
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: {
            HapticManager.shared.buttonTap()
            action()
        }) {
            ZStack {
                // Outer glow ring
                Circle()
                    .fill(themeManager.currentTheme.primaryGradient)
                    .frame(width: 80, height: 80)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .opacity(isAnimating ? 0.3 : 0.8)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                
                // Main button
                Circle()
                    .fill(themeManager.currentTheme.primaryGradient)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(themeManager.currentTheme.accentColor, lineWidth: 3)
                    )
                    .scaleEffect(isPressed ? 0.9 : 1.0)
                    .shadow(color: themeManager.currentTheme.accentColor.opacity(0.4), radius: 10, x: 0, y: 5)
                
                // Plus icon
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(isPressed ? 45 : 0))
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = pressing
            }
        }, perform: {})
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Floating Action Button Container

struct FloatingActionButtonContainer: View {
    @ObservedObject var themeManager: AnimeThemeManager
    let action: () -> Void
    @State private var showButton = false
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                if showButton {
                    FloatingActionButton(themeManager: themeManager, action: action)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        ))
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 100) // Above tab bar
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.5)) {
                showButton = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.1)
            .ignoresSafeArea()
        
        FloatingActionButtonContainer(
            themeManager: AnimeThemeManager(),
            action: { print("FAB tapped!") }
        )
    }
}

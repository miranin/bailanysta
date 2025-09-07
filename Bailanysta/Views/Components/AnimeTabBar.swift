//
//  AnimeTabBar.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeTabBar: View {
    @Binding var selectedTab: Int
    @ObservedObject var themeManager: AnimeThemeManager
    @State private var tabBarOffset: CGFloat = 0
    @State private var isAnimating = false
    
    let tabs = [
        TabItem(icon: "house.fill", selectedIcon: "house.fill", title: "Feed", emoji: "🏠"),
        TabItem(icon: "person.fill", selectedIcon: "person.fill", title: "Profile", emoji: "👤"),
        TabItem(icon: "gear", selectedIcon: "gear", title: "Settings", emoji: "⚙️")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                TabBarButton(
                    tab: tabs[index],
                    isSelected: selectedTab == index,
                    themeManager: themeManager,
                    action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = index
                        }
                        HapticManager.shared.buttonTap()
                    }
                )
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(themeManager.currentTheme.accentColor.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: themeManager.currentTheme.accentColor.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .offset(y: tabBarOffset)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                tabBarOffset = 0
            }
        }
    }
}

struct TabItem {
    let icon: String
    let selectedIcon: String
    let title: String
    let emoji: String
}

struct TabBarButton: View {
    let tab: TabItem
    let isSelected: Bool
    @ObservedObject var themeManager: AnimeThemeManager
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    // Background circle for selected state
                    if isSelected {
                        Circle()
                            .fill(themeManager.currentTheme.primaryGradient)
                            .frame(width: 50, height: 50)
                            .scaleEffect(isPressed ? 0.9 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                    }
                    
                    // Icon
                    Image(systemName: isSelected ? tab.selectedIcon : tab.icon)
                        .font(.system(size: isSelected ? 20 : 18, weight: .semibold))
                        .foregroundColor(isSelected ? .white : themeManager.currentTheme.accentColor)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
                }
                
                // Title
                Text(tab.title)
                    .font(.caption2)
                    .fontWeight(isSelected ? .bold : .medium)
                    .foregroundColor(isSelected ? themeManager.currentTheme.accentColor : .secondary)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

// MARK: - Custom Tab View

struct AnimeTabView: View {
    @State private var selectedTab = 0
    @State private var currentUser: User
    @StateObject private var themeManager = AnimeThemeManager()
    
    init() {
        self._currentUser = State(initialValue: User.sampleUsers[0])
    }
    
    var body: some View {
        ZStack {
            // Background
            themeManager.currentTheme.primaryGradient
                .ignoresSafeArea()
                .opacity(0.05)
            
            VStack(spacing: 0) {
                // Content
                Group {
                    switch selectedTab {
                    case 0:
                        FeedView(currentUser: currentUser, themeManager: themeManager)
                    case 1:
                        ProfileView(currentUser: currentUser, themeManager: themeManager)
                    case 2:
                        SettingsView(currentUser: $currentUser, themeManager: themeManager)
                    default:
                        FeedView(currentUser: currentUser, themeManager: themeManager)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Custom Tab Bar
                AnimeTabBar(selectedTab: $selectedTab, themeManager: themeManager)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
            }
        }
        .environmentObject(themeManager)
    }
}

#Preview {
    AnimeTabView()
}

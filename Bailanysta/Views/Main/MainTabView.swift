//
//  MainTabView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var currentUser: User
    @StateObject private var themeManager = AnimeThemeManager()
    @State private var selectedTab = 0

    init() {
        // Initialize with sample user for demo
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
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        .environmentObject(themeManager)
    }
}

#Preview {
    MainTabView()
}

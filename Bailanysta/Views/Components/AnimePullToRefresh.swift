//
//  AnimePullToRefresh.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimePullToRefresh: View {
    @ObservedObject var themeManager: AnimeThemeManager
    let onRefresh: () -> Void
    @State private var isRefreshing = false
    @State private var pullOffset: CGFloat = 0
    @State private var rotationAngle: Double = 0
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack(spacing: 12) {
            if isRefreshing {
                ZStack {
                    Circle()
                        .stroke(themeManager.currentTheme.accentColor.opacity(0.3), lineWidth: 3)
                        .frame(width: 40, height: 40)

                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(themeManager.currentTheme.accentColor, lineWidth: 3)
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(rotationAngle))
                        .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: rotationAngle)

                    Text("🌸")
                        .font(.system(size: 16))
                        .scaleEffect(scale)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: scale)
                }

                Text("Refreshing... ✨")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                VStack(spacing: 8) {
                    Text("🌸")
                        .font(.system(size: 24))
                        .rotationEffect(.degrees(pullOffset * 0.1))
                        .scaleEffect(1 + pullOffset * 0.001)

                    Text("Pull to refresh")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .opacity(0.7)
                }
            }
        }
        .frame(height: 60)
        .onAppear {
            if isRefreshing {
                startRefreshAnimation()
            }
        }
        .onChange(of: isRefreshing) { refreshing in
            if refreshing {
                startRefreshAnimation()
            }
        }
    }

    private func startRefreshAnimation() {
        rotationAngle = 360
        scale = 1.2
    }

    func updatePullOffset(_ offset: CGFloat) {
        pullOffset = offset
    }

    func startRefresh() {
        isRefreshing = true
        HapticManager.shared.buttonTap()
        onRefresh()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isRefreshing = false
        }
    }
}

// MARK: - Custom Refreshable Modifier

struct AnimeRefreshableModifier: ViewModifier {
    @ObservedObject var themeManager: AnimeThemeManager
    let onRefresh: () -> Void
    @State private var refreshOffset: CGFloat = 0
    @State private var isRefreshing = false

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                content

                if refreshOffset > 0 || isRefreshing {
                    AnimePullToRefresh(
                        themeManager: themeManager,
                        onRefresh: {
                            isRefreshing = true
                            onRefresh()

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                isRefreshing = false
                            }
                        }
                    )
                    .offset(y: -60 + refreshOffset)
                    .opacity(min(refreshOffset / 60, 1.0))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 {
                            refreshOffset = value.translation.height
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 100 && !isRefreshing {
                            isRefreshing = true
                            onRefresh()

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                isRefreshing = false
                            }
                        }

                        withAnimation(.spring()) {
                            refreshOffset = 0
                        }
                    }
            )
        }
    }
}

extension View {
    func animeRefreshable(themeManager: AnimeThemeManager, onRefresh: @escaping () -> Void) -> some View {
        self.modifier(AnimeRefreshableModifier(themeManager: themeManager, onRefresh: onRefresh))
    }
}

// MARK: - Enhanced ScrollView with Anime Refresh

struct AnimeScrollView<Content: View>: View {
    @ObservedObject var themeManager: AnimeThemeManager
    let content: Content
    let onRefresh: () -> Void
    @State private var isRefreshing = false

    init(themeManager: AnimeThemeManager, onRefresh: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.themeManager = themeManager
        self.onRefresh = onRefresh
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Refresh indicator
                if isRefreshing {
                    AnimePullToRefresh(themeManager: themeManager, onRefresh: {})
                        .frame(height: 60)
                }

                content
            }
        }
        .refreshable {
            isRefreshing = true
            HapticManager.shared.buttonTap()
            onRefresh()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isRefreshing = false
            }
        }
    }
}

#Preview {
    AnimeScrollView(
        themeManager: AnimeThemeManager(),
        onRefresh: {
            print("Refreshing...")
        }
    ) {
        VStack(spacing: 20) {
            ForEach(0..<10, id: \.self) { index in
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.3))
                    .frame(height: 100)
                    .overlay(
                        Text("Item \(index + 1)")
                            .font(.headline)
                    )
            }
        }
        .padding()
    }
}

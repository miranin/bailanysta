//
//  ProfileView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var presenter: ProfilePresenter
    @ObservedObject var themeManager: AnimeThemeManager
    @State private var showingEditProfile = false
    @State private var showingNewPost = false
    
    init(currentUser: User, themeManager: AnimeThemeManager) {
        self._presenter = StateObject(wrappedValue: ProfilePresenter(currentUser: currentUser))
        self.themeManager = themeManager
    }
    
    var body: some View {
        NavigationView {
            ZStack {
        
                themeManager.currentTheme.primaryGradient
                    .ignoresSafeArea()
                    .opacity(0.1)
                
                ScrollView {
                    VStack(spacing: 24) {
                        AnimeProfileHeaderView(
                            user: presenter.currentUser,
                            themeManager: themeManager,
                            onEditProfile: { showingEditProfile = true }
                        )
                        
                        // Stats
                        AnimeProfileStatsView(postsCount: presenter.userPosts.count, themeManager: themeManager)
                        
                        // New post button
                        Button(action: { showingNewPost = true }) {
                            HStack(spacing: 12) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                Text("Create New Post ✨")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(themeManager.currentTheme.primaryGradient)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(themeManager.currentTheme.accentColor, lineWidth: 2)
                            )
                            .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        
                        // User posts
                        if presenter.isLoading {
                            VStack(spacing: 16) {
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .tint(themeManager.currentTheme.accentColor)
                                
                                Text("Loading posts... ✨")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 200)
                        } else if presenter.userPosts.isEmpty {
                            VStack(spacing: 16) {
                                Text("📝")
                                    .font(.system(size: 60))
                                
                                Text("No posts yet")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                Text("Create your first post to get started! ✨")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(32)
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
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(presenter.userPosts) { post in
                                    AnimeUserPostCardView(
                                        post: post,
                                        themeManager: themeManager,
                                        onDelete: { presenter.deletePost(post) }
                                    )
                                    .animeCard(true, delay: Double(presenter.userPosts.firstIndex(where: { $0.id == post.id }) ?? 0) * 0.1)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("👨‍💻 Profile")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                presenter.loadUserPosts()
            }
        }
        .sheet(isPresented: $showingEditProfile) {
            AnimeEditProfileView(
                user: presenter.currentUser,
                themeManager: themeManager,
                onSave: { bio in
                    presenter.updateProfile(bio: bio)
                    showingEditProfile = false
                }
            )
        }
        .sheet(isPresented: $showingNewPost) {
            AnimeNewPostView(
                content: $presenter.newPostContent,
                themeManager: themeManager,
                onCreatePost: {
                    presenter.createPost()
                    showingNewPost = false
                }
            )
        }
    }
}

#Preview {
    ProfileView(currentUser: User.sampleUsers[0], themeManager: AnimeThemeManager())
}

//
//  FeedView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var presenter: FeedPresenter
    @ObservedObject var themeManager: AnimeThemeManager
    @State private var showingCommentSheet = false
    @State private var selectedPost: Post?
    @State private var showingNewPost = false
    @State private var newPostContent = ""
    
    init(currentUser: User, themeManager: AnimeThemeManager) {
        self._presenter = StateObject(wrappedValue: FeedPresenter(currentUser: currentUser))
        self.themeManager = themeManager
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                themeManager.currentTheme.primaryGradient
                    .ignoresSafeArea()
                    .opacity(0.1)
                
                if presenter.isLoading {
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(themeManager.currentTheme.accentColor)
                        
                        Text("Loading posts... ✨")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    AnimeScrollView(themeManager: themeManager, onRefresh: {
                        presenter.loadPosts()
                    }) {
                        LazyVStack(spacing: 20) {
                            ForEach(presenter.posts) { post in
                                AnimePostCardView(
                                    post: post,
                                    currentUser: presenter.currentUser,
                                    themeManager: themeManager,
                                    onLike: { presenter.likePost(post) },
                                    onComment: {
                                        selectedPost = post
                                        showingCommentSheet = true
                                    }
                                )
                                .animeCard(true, delay: Double(presenter.posts.firstIndex(where: { $0.id == post.id }) ?? 0) * 0.1)
                            }
                        }
                        .padding()
                    }
                }
                
                // Floating Action Button
                FloatingActionButtonContainer(themeManager: themeManager) {
                    showingNewPost = true
                }
            }
            .navigationTitle("Bailanysta")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                presenter.loadPosts()
            }
        }
        .sheet(isPresented: $showingCommentSheet) {
            if let post = selectedPost {
                AnimeCommentSheetView(post: post, presenter: presenter, themeManager: themeManager)
            }
        }
        .sheet(isPresented: $showingNewPost) {
            AnimeNewPostView(
                content: $newPostContent,
                themeManager: themeManager,
                onCreatePost: {
                    // Create a new post using the presenter
                    presenter.createPost(content: newPostContent)
                    // Clear the content and dismiss
                    newPostContent = ""
                    showingNewPost = false
                    HapticManager.shared.postCreated()
                }
            )
        }
    }
}

#Preview {
    FeedView(currentUser: User.sampleUsers[0], themeManager: AnimeThemeManager())
}

//
//  FeedPresenter.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import Foundation
import SwiftUI
import Combine

protocol FeedPresenterProtocol: ObservableObject {
    var posts: [Post] { get }
    var isLoading: Bool { get }
    var currentUser: User { get }
    
    func loadPosts()
    func likePost(_ post: Post)
    func addComment(to post: Post, content: String)
    func createPost(content: String)
}

class FeedPresenter: FeedPresenterProtocol {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var currentUser: User
    
    private let dataManager = PostsDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(currentUser: User) {
        self.currentUser = currentUser
        loadPosts()
        
        // Subscribe to data manager updates
        dataManager.$allPosts
            .map { $0.sorted { $0.timestamp > $1.timestamp } }
            .sink { [weak self] sortedPosts in
                self?.posts = sortedPosts
            }
            .store(in: &cancellables)
    }
    
    func loadPosts() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.posts = self.dataManager.getAllPosts()
            self.isLoading = false
        }
    }
    
    func likePost(_ post: Post) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
        var updatedPost = posts[index]
        updatedPost.toggleLike(for: currentUser)
        dataManager.updatePost(updatedPost)
    }
    
    func addComment(to post: Post, content: String) {
        guard let index = posts.firstIndex(where: { $0.id == post.id }) else { return }
        var updatedPost = posts[index]
        let comment = Comment(author: currentUser, content: content)
        updatedPost.comments.append(comment)
        dataManager.updatePost(updatedPost)
    }
    
    func createPost(content: String) {
        let newPost = Post(author: currentUser, content: content)
        dataManager.addPost(newPost)
    }
}

//
//  ProfilePresenter.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import Foundation
import SwiftUI
import Combine

protocol ProfilePresenterProtocol: ObservableObject {
    var currentUser: User { get }
    var userPosts: [Post] { get }
    var isLoading: Bool { get }
    var newPostContent: String { get set }
    var isShowingNewPost: Bool { get set }
    
    func loadUserPosts()
    func createPost()
    func deletePost(_ post: Post)
    func updateProfile(bio: String)
}

class ProfilePresenter: ProfilePresenterProtocol {
    @Published var currentUser: User
    @Published var userPosts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var newPostContent: String = ""
    @Published var isShowingNewPost: Bool = false
    
    private let dataManager = PostsDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(currentUser: User) {
        self.currentUser = currentUser
        loadUserPosts()
        
        // Subscribe to data manager updates
        dataManager.$allPosts
            .map { [weak self] posts in
                guard let self = self else { return [] }
                return posts
                    .filter { $0.author.id == self.currentUser.id }
                    .sorted { $0.timestamp > $1.timestamp }
            }
            .sink { [weak self] userPosts in
                self?.userPosts = userPosts
            }
            .store(in: &cancellables)
    }
    
    func loadUserPosts() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.userPosts = self.dataManager.getPostsForUser(self.currentUser)
            self.isLoading = false
        }
    }
    
    func createPost() {
        guard !newPostContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let newPost = Post(author: currentUser, content: newPostContent)
        dataManager.addPost(newPost)
        newPostContent = ""
        isShowingNewPost = false
    }
    
    func deletePost(_ post: Post) {
        dataManager.deletePost(post)
    }
    
    func updateProfile(bio: String) {
        // In a real app, this would update the user profile on the server
        // For now, we'll just update the local user object
        currentUser = User(
            username: currentUser.username,
            displayName: currentUser.displayName,
            email: currentUser.email,
            bio: bio,
            profileImageURL: currentUser.profileImageURL
        )
    }
}

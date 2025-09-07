//
//  PostsDataManager.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import Foundation
import SwiftUI

class PostsDataManager: ObservableObject {
    static let shared = PostsDataManager()
    
    @Published var allPosts: [Post] = []
    
    private init() {
        loadInitialPosts()
    }
    
    private func loadInitialPosts() {
        allPosts = Post.samplePosts
    }
    
    func addPost(_ post: Post) {
        allPosts.insert(post, at: 0)
    }
    
    func deletePost(_ post: Post) {
        allPosts.removeAll { $0.id == post.id }
    }
    
    func updatePost(_ post: Post) {
        if let index = allPosts.firstIndex(where: { $0.id == post.id }) {
            allPosts[index] = post
        }
    }
    
    func getPostsForUser(_ user: User) -> [Post] {
        return allPosts
            .filter { $0.author.id == user.id }
            .sorted { $0.timestamp > $1.timestamp }
    }
    
    func getAllPosts() -> [Post] {
        return allPosts.sorted { $0.timestamp > $1.timestamp }
    }
}

//
//  DataService.swift
//  Social-network
//
//  Created by Даша Николаева on 08.03.2025.
//

import UIKit

enum Errors: Error {
    case missingDataError
}

protocol DataServiceProtocol {
    func fetchPosts(offset: Int, limit: Int) -> [Post]
    func hasMorePosts(offset: Int, limit: Int) -> Bool
}

class DataService: DataServiceProtocol {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var posts: [Post] = []
    
    func fetchPosts(offset: Int, limit: Int) -> [Post] {
        let fetchRequest = PostEntity.fetchRequest()
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        do {
            let postsEntities = try context.fetch(fetchRequest)
            posts = try postsEntities.map { try convert(postEntity: $0) }
        } catch {
            print("Error while loading from DB: \(error)")
        }
        
        return posts
    }
    
    func hasMorePosts(offset: Int, limit: Int) -> Bool {
        let fetchRequest = PostEntity.fetchRequest()
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error while counting posts: \(error)")
            return false
        }
    }
    
    func convert(postEntity: PostEntity) throws -> Post {
        var post: Post
        if let title = postEntity.title, let body = postEntity.body, let image = postEntity.image {
            post = Post(title: title,
                        body: body,
                        image: image,
                        liked: postEntity.liked)
            return post
        }
        throw Errors.missingDataError
    }
}

//
//  DataService.swift
//  Social-network
//
//  Created by Даша Николаева on 08.03.2025.
//

import UIKit

// Custom error type to handle missing data errors
enum Errors: Error {
    case missingDataError
}

protocol DataServiceProtocol {
    func fetchPosts(offset: Int, limit: Int, completion: @escaping (Result<[Post], Error>) -> Void)
    func hasMorePosts(offset: Int, limit: Int) -> Bool
    func hasPost(with id: Int) -> Bool
}

class DataService: DataServiceProtocol {
    // Accessing the managed object context from the AppDelegate for CoreData operations
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var posts: [Post] = []
    
    // Fetch posts from the database with pagination (offset and limit)
    func fetchPosts(offset: Int, limit: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        let fetchRequest = PostEntity.fetchRequest()
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        do {
            let postsEntities = try context.fetch(fetchRequest)
            posts = try postsEntities.map { try convert(postEntity: $0) }
        } catch {
            print("Error while loading from DB: \(error)")
            completion(.failure(error))
            return
        }
        completion(.success(posts))
    }
    
    // Check if there are more posts available based on the current offset and limit
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
    
    // Check if a specific post exists in DB by its ID
    func hasPost(with id: Int) -> Bool {
        let fetchRequest = PostEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", Int64(id))
        do {
            let posts = try context.fetch(fetchRequest)
            return posts.count > 0
        } catch {
            print("Ошибка при получении поста по ID: \(error)")
            return false
        }
    }
    
    // Add a new post to the database
    func addPost(_ post: Post) {
        let _ = convert(post: post)
        do {
            try context.save()
        } catch {
            print("Ошибка при созранении поста с ID \(post.id): \(error)")
        }
        
    }
    
    // Convert a PostEntity (CoreData entity) to a Post model object
    func convert(postEntity: PostEntity) throws -> Post {
        var post: Post
        if let title = postEntity.title, let body = postEntity.body {
            post = Post(id: Int(postEntity.id),
                        title: title,
                        body: body,
                        image: postEntity.image,
                        liked: postEntity.liked)
            return post
        }
        throw Errors.missingDataError
    }
    
    // Convert a Post model object to a PostEntity (CoreData entity) saving to the database
    func convert(post: Post) -> PostEntity {
        var postEntity: PostEntity
        postEntity = PostEntity(context: context)
        postEntity.id = Int64(post.id)
        postEntity.title = post.title
        postEntity.body = post.body
        postEntity.image = post.image
        postEntity.liked = false
        return postEntity
    }
}

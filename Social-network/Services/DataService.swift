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
    func fetchPosts(offset: Int, limit: Int, completion: @escaping (Result<[Post], Error>) -> Void)
    func hasMorePosts(offset: Int, limit: Int) -> Bool
    func hasPost(with id: Int) -> Bool
}

class DataService: DataServiceProtocol {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var posts: [Post] = []
    
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
    
    func addPost(_ post: Post) {
        let _ = convert(post: post)
        do {
            try context.save()
        } catch {
            print("Ошибка при созранении поста с ID \(post.id): \(error)")
        }
        
    }
    
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

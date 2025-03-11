//
//  FeedRepository.swift
//  Social-network
//
//  Created by Даша Николаева on 08.03.2025.
//

import Foundation

protocol FeedRepositoryProtocol {
    func loadPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func loadRandomPhoto(complition: ((Result<Data, Error>) -> Void)?)
    func addToDB(_ posts: [Post])
    func loadPostsFromDB(completion: @escaping (Result<[Post], Error>) -> Void)
}

class FeedRepository: FeedRepositoryProtocol {
    let networkReachability = NetworkReachabilityService()
    let dataService = DataService()
    
    // Load posts from network or database depending on the internet connection
    func loadPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        networkReachability.isInternetAvailable {[weak self] available in
            if available {
                self?.loadPostsFromURL(completion: completion)
            } else {
                self?.loadPostsFromDB(completion: completion)
            }
        }
    }
    
    func loadPostsFromURL(completion: @escaping (Result<[Post], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        NetworkService.shared.fetchData(url: urlString) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let posts):
                self?.addToDB(posts)
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadRandomPhoto(complition: ((Result<Data, Error>) -> Void)? = nil) {
        let urlString = "https://picsum.photos/200"
        NetworkService.shared.fetchImage(url: urlString) { result in
            switch result {
            case .success(let data):
                complition?(.success(data))
            case .failure(let error):
                complition?(.failure(error))
                print("error while loading image: \(error)")
            }
        }
    }
    
    func addToDB(_ posts: [Post]) {
        posts.forEach { post in
            if !dataService.hasPost(with: post.id) {
                dataService.addPost(post)
            }
        }
    }
    
    func loadPostsFromDB(completion: @escaping (Result<[Post], Error>) -> Void) {
        dataService.fetchPosts(offset: 0, limit: 200) { (result: Result<[Post], Error>) in
            switch result {
            case .success(let posts):
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}

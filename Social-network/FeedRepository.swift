//
//  FeedRepository.swift
//  Social-network
//
//  Created by Даша Николаева on 08.03.2025.
//

class FeedRepository {
    let networkReachability = NetworkReachabilityService()
    let dataService = DataService()
    
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

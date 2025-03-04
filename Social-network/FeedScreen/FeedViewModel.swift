//
//  FeedViewModel.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import Foundation

protocol FeedViewModelProtocol {
    var posts: [Post] { get }
    var error: Error? { get }
    var isLoading: Bool { get }
    
    var view: FeedViewProtocol? { get }
    
    func loadPosts()
    func refreshPosts()
    func toggleLike(for postId: Int)
    func handleError()
}

class FeedViewModel: FeedViewModelProtocol {
    var view: FeedViewProtocol?
    
    private var _posts: [Post] = []
    private var _error: Error?
    private var _isLoading: Bool = false
    
    var posts: [Post] { _posts }
    var error: Error? { _error }
    var isLoading: Bool { _isLoading }
    
    func loadPosts() {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        NetworkService.shared.fetchData(url: urlString) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let posts):
                self?._posts = posts
            case .failure(let error):
                self?._error = error
            }
        }
    }
    
    func refreshPosts() {
        loadPosts()
        view?.reloadPosts()
    }
    
    func toggleLike(for postId: Int) {
        
    }
    
    func handleError() {
        view?.showError(message: "При загрузке произошла ошибка :( ")
    }
    
    func start() -> FeedViewProtocol {
        self.view = FeedView()
        self.view?.viewModel = self
        return self.view!
    }
    
}

//
//  FeedViewModel.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import Foundation
import UIKit

protocol FeedViewModelProtocol {
    var posts: [Post] { get set }
    var images: [Data] { get }
    var error: Error? { get }
    var isLoading: Bool { get }
    
    var view: FeedViewProtocol? { get }
    var repository: FeedRepositoryProtocol? { get }
    
    func loadPosts()
    func loadRandomPhoto(for index: Int, closure: (() -> Void)?)
    func refreshPosts()
    func toggleLike(for postId: Int)
    func handleError()
    func getImage(for index: Int) -> UIImage
    func loadNextPage()
}

class FeedViewModel: FeedViewModelProtocol {
    
    var view: FeedViewProtocol?
    
    private var _posts: [Post] = []
    private var allPosts: [Post] = []
    private var _images: [Data] = []
    private var _error: Error?
    private var _isLoading: Bool = false
    
    var posts: [Post] {
        get { _posts }
        set {_posts = newValue}
    }
    var images: [Data] { _images }
    var error: Error? { _error }
    var isLoading: Bool { _isLoading }
    
    var repository: FeedRepositoryProtocol?
    
    var currentPage = 1
    var pageSize = 20
    
    func loadPosts() {
        repository?.loadPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.allPosts = posts
                self?.loadNextPage()
                self?.view?.reloadPosts()
            case .failure(let error):
                self?._error = error
                self?.handleError()
            }
        }
    }
    
    func loadNextPage() {
        guard (currentPage - 1) * pageSize < allPosts.count else { return }
        _isLoading = true
        loadNextPagePosts(page: currentPage, pageSize: pageSize) { newPosts in
            self._isLoading = false
            self._posts.append(contentsOf: newPosts)
            self.currentPage += 1
            self.view?.reloadPosts()
        }
    }
    
    func loadNextPagePosts(page: Int, pageSize: Int, completion: @escaping ([Post]) -> Void) {
        let newPosts = Array(allPosts[(page - 1)*pageSize..<page*pageSize])
        completion(newPosts)
    }
    
    func loadRandomPhoto(for index: Int, closure: (() -> Void)? = nil) {
        repository?.loadRandomPhoto() {  [weak self] result in
            switch result {
            case .success(let data):
                self?._posts[index].image = data
                closure?()
            default:
                break
            }
        }
    }
    
    func getImage(for index: Int) -> UIImage {
        if let data = posts[index].image {
            if let image = UIImage(data: data) {
                return image
            }
        }
        loadRandomPhoto(for: index) {
            self.view?.reloadPost(at: index)
        }
        return UIImage(named: "placeholder")!
    }
    
    func refreshPosts() {
        loadPosts()
        view?.reloadPosts()
    }
    
    func toggleLike(for postId: Int) {
        guard _posts[postId].liked != nil else {
            _posts[postId].liked = true
            return
        }
        _posts[postId].liked?.toggle()
    }
    
    func handleError() {
        view?.showError(message: "При загрузке произошла ошибка :( ")
    }
    
    func removeError() {
        view?.hideError()
    }
    
    func start(view: FeedViewProtocol? = nil, repository: FeedRepositoryProtocol? = nil) {
        self.view = view
        self.repository = repository
        self.view?.viewModel = self
        self.loadPosts()
    }
    
}

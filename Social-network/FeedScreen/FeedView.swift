//
//  FeedView.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import UIKit

protocol FeedViewProtocol {
    var viewModel: FeedViewModelProtocol? { get set }
    func reloadPosts()
    func showError(message: String)
    func toggleLike(for postId: Int)
}

class FeedView: UIViewController, FeedViewProtocol {
    var viewModel: (any FeedViewModelProtocol)?
    
    var postsTableView: UITableView!
    var errorView: ErrorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func reloadPosts() {
        
    }
    
    func showError(message: String) {
        postsTableView.isHidden = true
        errorView.setErrorText(message)
        errorView.isHidden = false
    }
    
    func toggleLike(for postId: Int) {
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        errorView = ErrorView()
        errorView.isHidden = true
        view.addSubview(errorView)
        
        postsTableView = UITableView()
//        postsTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        view.addSubview(postsTableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        postsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


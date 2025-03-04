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
    func reloadPost(at index: Int)
}

class FeedView: UIViewController, FeedViewProtocol {
    var viewModel: (any FeedViewModelProtocol)?
    
    var postsTableView: UITableView!
    var errorView: ErrorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        viewModel?.loadPosts()
    }
    
    func reloadPosts() {
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
        }
    }
    
    func reloadPost(at index: Int) {
        DispatchQueue.main.async {
            self.postsTableView.reloadRows(at: [IndexPath(row: 0, section: index)], with: .none)
        }
    }
    
    func showError(message: String) {
        postsTableView.isHidden = true
        errorView.setErrorText(message)
        errorView.isHidden = false
    }
    
    func toggleLike(for postId: Int) {
        
    }
    
    func setupTableView() {
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "postsCell")
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsTableView.allowsSelection = false
    }
}


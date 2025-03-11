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
    func hideError()
    func toggleLike(cell: UITableViewCell)
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
        configureRefreshControl()
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
    
    func hideError() {
        errorView.isHidden = true
        postsTableView.isHidden = false
    }
    
    func toggleLike(cell: UITableViewCell) {
        if let indexPath = postsTableView.indexPath(for: cell) {
            viewModel?.toggleLike(for: indexPath.section)
            if let cell = cell as? PostsTableViewCell {
                cell.updateLikeButton(viewModel?.posts[indexPath.section].liked ?? false)
            }
        }
    }
    
    func setupTableView() {
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "postsCell")
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsTableView.allowsSelection = false
    }
    
    func configureRefreshControl() {
        postsTableView.refreshControl = UIRefreshControl()
        postsTableView.refreshControl?.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
    }
    
    @objc func refreshControlAction() {
        reloadPosts()
        DispatchQueue.main.async {
            self.postsTableView.refreshControl?.endRefreshing()
       }
    }
}


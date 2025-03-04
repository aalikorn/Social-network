//
//  FeedView+setupUI.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import UIKit

extension FeedView {
    func setupUI() {
        view.backgroundColor = .white
        
        errorView = ErrorView()
        errorView.isHidden = true
        view.addSubview(errorView)
        
        postsTableView = UITableView()
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

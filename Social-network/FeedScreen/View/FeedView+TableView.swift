//
//  FeedView+TableView.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import UIKit

extension FeedView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsTableViewCell
        let post = viewModel!.posts[indexPath.section]
        cell.configure(image: viewModel!.getImage(for: indexPath.section), title: post.title, body: post.body, isLiked: post.liked ?? false)
        cell.onLikeButtonTap = toggleLike(cell:)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.posts.count ?? 0
    }
}

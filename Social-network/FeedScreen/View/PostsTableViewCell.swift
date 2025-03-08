//
//  PostsTableViewCell.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    private var avatarImage: UIImageView!
    private var titleLabel: UILabel!
    private var bodyLabel: UILabel!
    private var likeButton: UIButton!
    
    var onLikeButtonTap: ((UITableViewCell) -> Void)?
    
    let likeButtonConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
    
    func configure(image: UIImage, title: String, body: String, isLiked: Bool) {
        avatarImage = UIImageView()
        avatarImage.image = image
        avatarImage.contentMode = .scaleAspectFit
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 25
        contentView.addSubview(avatarImage)
        
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(titleLabel)
        
        bodyLabel = UILabel()
        bodyLabel.text = body
        bodyLabel.numberOfLines = 0
        bodyLabel.font = .systemFont(ofSize: 17, weight: .regular)
        contentView.addSubview(bodyLabel)
        
        likeButton = UIButton()
        updateLikeButton(isLiked)
        likeButton.tintColor = .red
        likeButton.layer.borderColor = UIColor.red.cgColor
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        contentView.addSubview(likeButton)
        
        setupConstraints()
    }
    
    func updateLikeButton(_ isLiked: Bool) {
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName, withConfiguration: likeButtonConfig), for: .normal)
    }
    
    @objc func likeButtonTapped() {
        onLikeButtonTap?(self)
    }
    
    private func setupConstraints() {
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImage.widthAnchor.constraint(equalToConstant: 50),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        titleLabel.text = nil
        bodyLabel.text = nil
        updateLikeButton(false)
    }
}

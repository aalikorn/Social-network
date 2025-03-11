//
//  ErrorView.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import UIKit

class ErrorView: UIView {
    private let errorLabel = UILabel()
    
    private func configure() {
        errorLabel.numberOfLines = 0
        errorLabel.font = .systemFont(ofSize: 17, weight: .medium)
        errorLabel.textColor = .black
        addSubview(errorLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 32),
            errorLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -32),
        ])
    }
    
    // method to update the text of the error label
    public func setErrorText(_ text: String) {
        errorLabel.text = text
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

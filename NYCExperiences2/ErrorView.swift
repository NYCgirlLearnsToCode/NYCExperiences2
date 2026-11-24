//
//  ErrorView.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/17/26.
//

import UIKit

class ErrorView: UIView {

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var onRetryTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(errorLabel)
        addSubview(retryButton)

        retryButton.addTarget(
            self,
            action: #selector(retryButtonTapped),
            for: .touchUpInside)

        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 8.0)
        ])
    }

    @objc private func retryButtonTapped() {
        onRetryTapped?()
    }

    func configure(with error: Error) {
        errorLabel.text = error.localizedDescription
    }
}

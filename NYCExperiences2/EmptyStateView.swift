//
//  EmptyStateView.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/17/26.
//

import UIKit

class EmptyStateView: UIView {

    private lazy var emptyStatelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No products available"
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(emptyStatelabel)

        emptyStatelabel.backgroundColor = .white
        emptyStatelabel.textColor = .black

        NSLayoutConstraint.activate([
            emptyStatelabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStatelabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

//
//  ExperienceDetailViewController.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/10/26.
//

import UIKit

class ExperienceDetailViewController: UIViewController {

    let experience: Experience

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = experience.title
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    init(experience: Experience) {
        self.experience = experience
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

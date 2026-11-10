//
//  ExperienceDetailViewController.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/10/26.
//

import UIKit

class ExperienceDetailViewController: UIViewController {

    let experience: Experience

    let imageLoader: ImageLoader

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.text = experience.title
        return label
    }()

    private lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .systemCyan
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "$\(experience.price)"
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = experience.description
        label.numberOfLines = 10
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadImage()
    }

    init(experience: Experience, imageLoader: ImageLoader) {
        self.experience = experience
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadImage() {
        if let url = URL(string: experience.imageUrl) {
            imageLoader.getImageFrom(url: url) { image in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let image = image else {
                        self.imgView.image = UIImage(systemName: "photo.fill")
                        return
                    }
                    self.imgView.image = image
                }
            }
        }
    }

    func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(titleLabel)
        self.view.addSubview(imgView)
        self.view.addSubview(subtitleLabel)
        self.view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 120),
            imgView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8.0),
            imgView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8.0),

            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imgView.topAnchor, constant: -8.0),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 8.0),

            subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8.0),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8.0),
            subtitleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 8),

            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 8.0),

        ])
    }
}

//
//  ExperienceCell.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

class ExperienceCell: UICollectionViewCell {

    private var representedImageUrl: URL?
    var imageLoader: ImageLoader?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true

        return imgView
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        imgView.image = nil
        subtitleLabel.text = ""
        representedImageUrl = nil
        loadingIndicator.stopAnimating()
    }

    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imgView)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 120),

            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 8.0),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: imgView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: imgView.centerYAnchor)
        ])
    }

    func configureWith(_ experience: Experience) {
        self.imgView.image = nil
        self.loadingIndicator.startAnimating()
        self.titleLabel.text = experience.title

        let url = URL(string: experience.imageUrl)
        self.representedImageUrl = url

        if let url = url, let imageLoader = imageLoader {
            imageLoader.getImageFrom(url: url) { [weak self] image in

                DispatchQueue.main.async {
                    guard let self = self, self.representedImageUrl == url else { return }
                    self.imgView.image = image
                    self.loadingIndicator.stopAnimating()
                }
            }
        } else {
            self.loadingIndicator.stopAnimating()
            self.imgView.image = UIImage(systemName: "photo.fill")
        }
        self.subtitleLabel.text = "$\(experience.price)"
    }
}

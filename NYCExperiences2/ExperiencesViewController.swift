//
//  ViewController.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

class ExperiencesViewController: UIViewController {

    private let imageLoader: ImageLoader = URLSessionImageLoader()
    
    var experiences = [Experience]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 12,
            left: 16,
            bottom: 12,
            right: 16
        )

        let collView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.backgroundColor = .systemBackground
        return collView
    }()

    private lazy var loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ExperienceCell.self,
                                forCellWithReuseIdentifier: "Cell")
        self.view.backgroundColor = .systemBackground
        self.title = "NYC Experiences"
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loaderView.startAnimating()
        }
        ProductService().getProducts() { [weak self] products in
            guard let self = self else { return }
            if let products = products {
                DispatchQueue.main.async {
                    self.experiences = products.map {Experience(product: $0)}
                    self.loaderView.stopAnimating()
                }
            } else {
                self.loaderView.stopAnimating()
            }
        }
        setupViews()
    }

    func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(loaderView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ExperiencesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // grab experience
        let experience = experiences[indexPath.row]
        // pass experience to detail vc
        let detailVC = ExperienceDetailViewController(experience: experience, imageLoader: self.imageLoader)
        //navigate to detail vc
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ExperiencesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        return CGSize(width: width, height: 280)
    }
}

extension ExperiencesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return experiences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath) as! ExperienceCell
        cell.imageLoader = imageLoader
        let experience = experiences[indexPath.row]
        cell.configureWith(experience)
        return cell
    }
    
}

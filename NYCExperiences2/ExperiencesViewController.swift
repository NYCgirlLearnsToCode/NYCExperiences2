//
//  ViewController.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

enum ViewState {
    case loadedWithProducts
    case loadedNoProducts
    case failure(error: Error)
    case loading
}

class ExperiencesViewController: UIViewController {

    private let imageLoader: ImageLoader = URLSessionImageLoader()

    var currentState: ViewState = .loading {
        didSet {
            switch currentState {
            case .loadedWithProducts:
                collectionView.backgroundView = nil
                loaderView.stopAnimating()
            case .loadedNoProducts:
                collectionView.backgroundView = emptyStateView
                loaderView.stopAnimating()
            case .failure:
                collectionView.backgroundView = errorView
                loaderView.stopAnimating()
            case .loading:
                collectionView.backgroundView = nil
                loaderView.startAnimating()
            }
        }
    }

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

    private lazy var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        return view
    }()

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ExperienceCell.self,
                                forCellWithReuseIdentifier: "Cell")
        self.view.backgroundColor = .systemBackground
        self.title = "NYC Experiences"

        setupViews()
        setupErrorView()
        getProducts()
    }

    private func getProducts() {
        currentState = .loading
        loaderView.startAnimating()
        ProductService().getProducts() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    if products.isEmpty {
                        self.currentState = .loadedNoProducts
                    } else {
                        self.experiences = products.map { Experience(product: $0)}
                        self.currentState = .loadedWithProducts
                    }
                case .failure(let error):
                    self.currentState = .failure(error: error)
                }
                self.loaderView.stopAnimating()
            }
        }
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

    func setupErrorView() {
        errorView.onRetryTapped = { [weak self] in
            guard let self = self else { return }
            self.getProducts()
        }
    }
}

extension ExperiencesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let experience = experiences[indexPath.row]
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

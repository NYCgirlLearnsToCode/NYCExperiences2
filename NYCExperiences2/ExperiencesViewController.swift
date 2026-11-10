//
//  ViewController.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

class ExperiencesViewController: UIViewController {

    private let imageLoader: ImageLoader = URLSessionImageLoader()
    
    var experiences = [Experience]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 220)

        let collView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.backgroundColor = .systemBackground
        return collView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ExperienceCell.self,
                                forCellWithReuseIdentifier: "Cell")
        self.view.backgroundColor = .systemBackground
        self.title = "NYC Experiences"
        ProductService().getProducts() { products in
//      TODO: add converted products to experiences
//            for product in products {
//                self.experiences.append(Experience(product: product))
//            }
        }
        setupViews()

        
    }

    func setupViews() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

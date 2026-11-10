//
//  ViewController.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

class ExperiencesViewController: UIViewController {

    private let imageLoader: ImageLoader = URLSessionImageLoader()

    var experiences = [Experience(title: "Garden workshop",
                                price: 5.00,
                                imageUrl: "https://plus.unsplash.com/premium_photo-1680286739871-01142bc609df?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
                                 description: "Intro to gardening sdfgthyjuikolkiuygtfrdes rtytguyhijokjuhygftdrex ygyhujhbgvf ugihuyg END"),
                     Experience(title: "Arts and crafts",
                                price: 0.0,
                                imageUrl: "https://images.unsplash.com/photo-1616706161242-f1d591350d1c?q=80&w=1567&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
                                description: "Intro to arts and crafts sdfgthyjuikolkiuygtfrdes rtytguyhijokjuhygftdrex ygyhujhbgvf ugihuyg sdfgthyjuikolkiuygtfrdes rtytguyhijokjuhygftdrex ygyhujhbgvf ugihuyg END"),
                     Experience(title: "Photography",
                                price: 19.99,
                                imageUrl: "https://plus.unsplash.com/premium_photo-1674389991678-0836ca77c7f7?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
                                description: "Intro to photography sdfgthyjuikolkiuygtfrdes rtytguyhijokjuhygftdrex ygyhujhbgvf ugihuyg sdfgthyjuikolkiuygtfrdes rtytguyhijokjuhygftdrex ygyhujhbgvf ugihuyg sdfgthyjuikolkiuygtfrdes rtytguyhijokjuhygftdrex ygyhujhbgvf ugihuyg END")]

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

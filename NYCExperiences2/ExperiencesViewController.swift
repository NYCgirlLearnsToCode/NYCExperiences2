//
//  ViewController.swift
//  NYCExperiences2
//
//  Created by Lisa J on 11/4/26.
//

import UIKit

class ExperiencesViewController: UIViewController {

    private let imageLoader: ImageLoader = URLSessionImageLoader()

    var experiences = [
        Experience(
            title: "Garden workshop",
            price: 5.00,
            imageUrl: "https://plus.unsplash.com/premium_photo-1680286739871-01142bc609df?q=80&w=1470&auto=format&fit=crop",
            description: "Intro to gardening, learning urban plant care, soil composition, and seasonal planting basics for small spaces. END"
        ),
        Experience(
            title: "Arts and crafts",
            price: 0.00,
            imageUrl: "https://images.unsplash.com/photo-1616706161242-f1d591350d1c?q=80&w=1567&auto=format&fit=crop",
            description: "Intro to arts and crafts exploring mixed media, paper folding, and hands-on creative design techniques. All skill levels welcome. END"
        ),
        Experience(
            title: "Photography",
            price: 19.99,
            imageUrl: "https://plus.unsplash.com/premium_photo-1674389991678-0836ca77c7f7?q=80&w=1470&auto=format&fit=crop",
            description: "Intro to photography covering camera framing, lighting fundamentals, and capturing urban street scenes with confidence. END"
        ),
        Experience(
            title: "Baking sourdough",
            price: 12.50,
            imageUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1470&auto=format&fit=crop",
            description: "Learn the fundamentals of maintaining a sourdough starter, mixing dough, shaping loaves, and achieving the ultimate crust. END"
        ),
        Experience(
            title: "Pottery basics",
            price: 25.00,
            imageUrl: "https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?q=80&w=1470&auto=format&fit=crop",
            description: "An introductory hands-on class covering wheel throwing, clay conditioning, centering, and basic pottery shaping techniques. END"
        ),
        Experience(
            title: "Coffee brewing masterclass",
            price: 15.00,
            imageUrl: "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?q=80&w=1470&auto=format&fit=crop",
            description: "Explore pour-over ratios, grind sizes, and water temperature variables to craft the perfect cup of specialty coffee at home. END"
        ),
        Experience(
            title: "Urban sketching",
            price: 0.00,
            imageUrl: "https://images.unsplash.com/photo-1513364776144-60967b0f800f?q=80&w=1470&auto=format&fit=crop",
            description: "Quick-gesture drawing, architectural perspective, and capturing vibrant street life in ink and light watercolor washes. END"
        ),
        Experience(
            title: "Cocktail mixology",
            price: 35.00,
            imageUrl: "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?q=80&w=1470&auto=format&fit=crop",
            description: "Master flavor balance, essential shaking and stirring methods, and craft custom infused syrups for classic cocktails. END"
        ),
        Experience(
            title: "Introductory rock climbing",
            price: 22.00,
            imageUrl: "https://images.unsplash.com/photo-1522163182402-834f871fd851?q=80&w=1470&auto=format&fit=crop",
            description: "Bouldering fundamentals for beginners, safety protocols, route reading, and learning efficient body movement holds. END"
        ),
        Experience(
            title: "Yoga & mindfulness",
            price: 10.00,
            imageUrl: "https://images.unsplash.com/photo-1545205597-3d9d02c29597?q=80&w=1470&auto=format&fit=crop",
            description: "Gentle Vinyasa flow, grounding breathwork exercises, and guided meditation designed for daily stress reduction. END"
        ),
        Experience(
            title: "Fermentation workshop",
            price: 18.00,
            imageUrl: "https://images.unsplash.com/photo-1589135233689-d53631804f95?q=80&w=1470&auto=format&fit=crop",
            description: "Learn traditional brining techniques to make gut-healthy kimchi, sauerkraut, and fermented garden vegetables. END"
        ),
        Experience(
            title: "Intro to woodworking",
            price: 45.00,
            imageUrl: "https://images.unsplash.com/photo-1538688525198-9b88f6f53126?q=80&w=1470&auto=format&fit=crop",
            description: "Hands-on instruction with traditional hand tools, wood sanding, simple joinery, and oil finishing methods. END"
        ),
        Experience(
            title: "Creative writing lab",
            price: 0.00,
            imageUrl: "https://images.unsplash.com/photo-1455390582262-044cdead277a?q=80&w=1470&auto=format&fit=crop",
            description: "Overcome writer's block through collaborative prompts, character building exercises, and constructive feedback. END"
        ),
        Experience(
            title: "Pasta making from scratch",
            price: 28.50,
            imageUrl: "https://images.unsplash.com/photo-1551183053-bf91a1d81141?q=80&w=1470&auto=format&fit=crop",
            description: "Knead egg dough, roll thin pasta sheets, and shape fresh fettuccine and stuffed ravioli with authentic sauces. END"
        ),
        Experience(
            title: "Intro to astronomy",
            price: 8.00,
            imageUrl: "https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?q=80&w=1470&auto=format&fit=crop",
            description: "Stargazing fundamentals, basic telescope setup, and locating major constellations and planets in the night sky. END"
        ),
        Experience(
            title: "Beekeeping introduction",
            price: 14.00,
            imageUrl: "https://images.unsplash.com/photo-1587049352847-4a222e784d38?q=80&w=1470&auto=format&fit=crop",
            description: "Understand hive dynamics, bee colony biology, essential equipment, and urban backyard beekeeping best practices. END"
        ),
        Experience(
            title: "Modern calligraphy",
            price: 16.00,
            imageUrl: "https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?q=80&w=1470&auto=format&fit=crop",
            description: "Brush pen angle control, fundamental stroke pressure, letterform construction, and custom card lettering design. END"
        ),
        Experience(
            title: "Intro to DJing",
            price: 30.00,
            imageUrl: "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=1470&auto=format&fit=crop",
            description: "Beatmatching basics, equalizer mixing techniques, and track transition controls on modern digital controllers. END"
        ),
        Experience(
            title: "Bicycle maintenance",
            price: 0.00,
            imageUrl: "https://images.unsplash.com/photo-1485965120184-e220f721d03e?q=80&w=1470&auto=format&fit=crop",
            description: "Fixing roadside flat tires, adjusting derailleur gears, chain lubrication, and brake alignment safety checks. END"
        ),
        Experience(
            title: "Candle pouring workshop",
            price: 20.00,
            imageUrl: "https://images.unsplash.com/photo-1603006905003-be475563bc59?q=80&w=1470&auto=format&fit=crop",
            description: "Soy wax melting, fragrance oil blending techniques, wick placement, and pouring your own scented glass candle. END"
        ),
        Experience(
            title: "Herbal tea blending",
            price: 11.00,
            imageUrl: "https://images.unsplash.com/photo-1576092768241-dec231879fc3?q=80&w=1470&auto=format&fit=crop",
            description: "Discover dried botanicals, evaluate flavor notes, and combine loose leaves into custom wellness tea blends. END"
        ),
        Experience(
            title: "Intro to coding (Python)",
            price: 0.00,
            imageUrl: "https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?q=80&w=1470&auto=format&fit=crop",
            description: "Fundamental variables, logic statements, loops, and writing your first practical text automation script in Python. END"
        ),
        Experience(
            title: "Terrarium building",
            price: 24.00,
            imageUrl: "https://images.unsplash.com/photo-1448375240586-882707db888b?q=80&w=1470&auto=format&fit=crop",
            description: "Layering drainage soil, arranging moss and mini succulents, and crafting a self-sustaining glass terrarium. END"
        ),
        Experience(
            title: "Improv comedy basics",
            price: 15.00,
            imageUrl: "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1470&auto=format&fit=crop",
            description: "Active listening drills, 'yes, and' scene building, and collaborative comedic storytelling for confidence. END"
        ),
        Experience(
            title: "Intro to watercolor painting",
            price: 14.50,
            imageUrl: "not a valid url",
            description: "Wet-on-wet washes, pigment transparency, color mixing basics, and painting simple botanical study studies. END"
        ),
        Experience(
            title: "Knitting for beginners",
            price: 9.00,
            imageUrl: "https://images.unsplash.com/photo-1619252584172-a83a949b6efd?q=80&w=1470&auto=format&fit=crop",
            description: "Cast-on yarn technique, practicing fundamental knit and purl stitches, binding off, and reading basic patterns. END"
        ),
        Experience(
            title: "Board game strategy night",
            price: 5.00,
            imageUrl: "https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?q=80&w=1470&auto=format&fit=crop",
            description: "Learn rules, resource management mechanics, and positional tactics across popular modern tabletop games. END"
        ),
        Experience(
            title: "Intro to salsa dancing",
            price: 12.00,
            imageUrl: "https://images.unsplash.com/photo-1504609773096-104ff2c73ba4?q=80&w=1470&auto=format&fit=crop",
            description: "Master basic salsa steps, rhythm timing, cross-body leads, and beginner partner coordination on the dance floor. END"
        ),
        Experience(
            title: "Mushroom foraging walk",
            price: 22.50,
            imageUrl: "https://images.unsplash.com/photo-1504470695779-75300268aa0e?q=80&w=1470&auto=format&fit=crop",
            description: "Guided forest trail walk learning safe fungal identification, spore printing, and forest ecosystem roles. END"
        ),
        Experience(
            title: "Mindfulness journaling",
            price: 0.00,
            imageUrl: "https://images.unsplash.com/photo-1517842645767-c639042777db?q=80&w=1470&auto=format&fit=crop",
            description: "Guided writing prompts for self-reflection, stress processing, goal mapping, and daily gratitude journaling habits. END"
        )
    ]
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

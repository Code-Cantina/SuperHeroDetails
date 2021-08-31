//
//  HeroHomeVC.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

import UIKit

class HeroHomeVC: HeroMainBackVC {
    
    //MARK: - Private Properties
    
    private var featuredHeros: [HeroData] = []
    private var displayedHero: HeroData!
    
    //I randomly put together this list of strings. Will randomly grab 1 each view load and fetch heros to be used as featured
    private let randomFeaturedHeroDataSearches = ["Star", "Woman", "King", "Man", "Black", "Hawk", "Green", "Night", "Dark", "Doc"]
    
    private let pageHeaderLbl = HeroHeaderLabel(text: "Featured Hero's")
    
    private let featuredContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let featuredCellId = "featuredCellId"
    private var isSwipingRight: Bool = false
    private let featuredCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .secondarySystemBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private var detailsArea: HeroDetailsView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupHeader()
        setupFeaturedContainerView()
        loadFeaturedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Setup UI
    private func setupHeader() {
        view.addSubview(pageHeaderLbl)
        
        NSLayoutConstraint.activate([
            pageHeaderLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.standardViewPadding),
            pageHeaderLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.standardViewPadding),
            pageHeaderLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.standardViewPadding)
        ])
    }
    
    private func setupFeaturedContainerView() {
        view.addSubview(featuredContainerView)
        featuredContainerView.addSubview(featuredCollectionView)
        
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        featuredCollectionView.register(FeaturedHeroCell.self, forCellWithReuseIdentifier: featuredCellId)
        
        NSLayoutConstraint.activate([
            featuredContainerView.topAnchor.constraint(equalTo: pageHeaderLbl.bottomAnchor, constant: Layout.standardViewPadding),
            featuredContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.standardViewPadding),
            featuredContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.standardViewPadding),
            featuredContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.standardViewPadding),
            
            featuredCollectionView.topAnchor.constraint(equalTo: featuredContainerView.topAnchor),
            featuredCollectionView.leadingAnchor.constraint(equalTo: featuredContainerView.leadingAnchor, constant: 2),
            featuredCollectionView.trailingAnchor.constraint(equalTo: featuredContainerView.trailingAnchor), //not adding padding here to give illusion
            featuredCollectionView.heightAnchor.constraint(equalToConstant: 267), //found this number playing around trial and error

        ])
        
    }
    
    private func setupDetailsView() {
        detailsArea = HeroDetailsView(hero: self.displayedHero)
        featuredContainerView.addSubview(detailsArea)
        
        NSLayoutConstraint.activate([
            detailsArea.topAnchor.constraint(equalTo: featuredCollectionView.bottomAnchor, constant: Layout.standardViewPadding),
            detailsArea.leadingAnchor.constraint(equalTo: featuredContainerView.leadingAnchor),
            detailsArea.trailingAnchor.constraint(equalTo: featuredContainerView.trailingAnchor),
            detailsArea.bottomAnchor.constraint(equalTo: featuredContainerView.bottomAnchor, constant: -Layout.standardViewPadding)
        ])
        
    }
    
    //MARK: - Data
    
    private func loadFeaturedData() {
        if let searchParam = self.randomFeaturedHeroDataSearches.randomElement() {
            self.searchForHeros(forText: searchParam)
        }
    }
    
    private func searchForHeros(forText: String) {
        displayLoadingView()
        NetworkManager.shared.fetchSearchResults(for: forText) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let heros):
                if heros.results.count > 0 {
                    self.featuredHeros = heros.results
                    self.displayedHero = self.featuredHeros[0]
                    DispatchQueue.main.async {
                        self.setupDetailsView()
                        self.updateFeaturedHeroInfo(hero: self.displayedHero)
                        self.featuredCollectionView.reloadData()
                    }
                } else {
                    //display some other message to user..
                }
               
            case .failure(let error):
                //TODO Handle it :)
                print("error: \(error)")
            }
        }
    }

    /// Update the featured hero info display elements for the hero found at provided array index
    private func updateFeaturedHeroInfo(hero: HeroData) {
        self.detailsArea.updateHero(hero: hero)
    }
    
}

//MARK: - Collection View Delegates
extension HeroHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //check if user is swiping right or left. Store value
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).x > 0 {
            self.isSwipingRight = true
         } else {
            self.isSwipingRight = false
        }
        
        //animate the cell that is the active/visible. make the cells slightly smaller as the swipe away while the active cell expands to full size
        let centerX = scrollView.contentOffset.x + scrollView.frame.size.width / 2
        for cell in featuredCollectionView.visibleCells {
            var offsetX = centerX - cell.center.x
            if offsetX < 0 {
                offsetX *= -1
            }
            
            cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            if offsetX > 50 {
                let offsetPercentage = (offsetX - 50) / view.bounds.width
                var scaleX = 1 - offsetPercentage
                
                if scaleX < 0.9 {
                    scaleX = 0.9
                }
                cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
            }
        }
        
    }

    // This is used to snap through cells. a paging type effect. Cannot use paging enabled on collection view since the cells are not full width
    // This method triggers when the user stops swiping on the collection view
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = self.featuredCollectionView.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        let cell = self.featuredCollectionView.cellForItem(at: index)! as! FeaturedHeroCell
        let position = self.featuredCollectionView.contentOffset.x - cell.frame.origin.x //how much has the cell moved

        //the '4' here comes from trial of dif values for the desired effect. basically if the user swipes more than 25% of the cell away go to the next cell.
        if position > cell.frame.size.width / 4 {
            if !self.isSwipingRight { //if the user is swiping left add 1 to the index row
                index.row = index.row + 1
            }
        }

        self.featuredCollectionView.scrollToItem(at: index, at: .left, animated: true )

        //update the featured hero information to the active hero in view
        let hero = featuredHeros[index.row]
        self.updateFeaturedHeroInfo(hero: hero)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if featuredHeros.count == 0 {
            collectionView.setEmptyMessage("No featured data found. Please check network.")
        } else {
            collectionView.restore()
        }
        return featuredHeros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hero = featuredHeros[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredCellId, for: indexPath as IndexPath) as! FeaturedHeroCell
        
        if !hero.image.url.isEmpty {
            NetworkManager.shared.downloadImage(from: hero.image.url) { image in
                DispatchQueue.main.async {
                    cell.logoImageView.image = image
                }
            }
        } else {
            cell.logoImageView.image = AppImages.defaultHeroImage
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 250) //these values seem good for the images provided
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


//
//  HeroSearchVC.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

import UIKit

class HeroSearchVC: HeroMainBackVC {
    
    //MARK: - Properties
    private let pageHeaderLbl = HeroHeaderLabel(text: "Search Hero's")
    
    private let heroSearchBar = HeroSearchBar(placeholder: "Search Hero's by Name", backgroundImage: UIImage())
    
    private let heroCellId = "heroCellId"
    private lazy var searchedHerosCV: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.backgroundColor = .secondarySystemGroupedBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let cellHeight: CGFloat = 65
    private let cellPadding: CGFloat = 15
    private let cellInset: CGFloat = 5
    
    private var heroResults: [HeroData] = []
    
    //MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupHeaderSearchField()
        setupCommonSearchCV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Setup
    
    private func setupHeaderSearchField() {
        view.addSubview(pageHeaderLbl)
        view.addSubview(heroSearchBar)
        
        heroSearchBar.delegate = self
        
        NSLayoutConstraint.activate([
            pageHeaderLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.standardViewPadding),
            pageHeaderLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.standardViewPadding),
            pageHeaderLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.standardViewPadding),
            
            heroSearchBar.topAnchor.constraint(equalTo: pageHeaderLbl.bottomAnchor, constant: Layout.standardViewPadding),
            heroSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.standardViewPadding),
            heroSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.standardViewPadding),
            heroSearchBar.heightAnchor.constraint(equalToConstant: Layout.searchBarHeight)
        ])
    }
    
    private func setupCommonSearchCV() {
        view.addSubview(searchedHerosCV)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        searchedHerosCV.collectionViewLayout = layout
        searchedHerosCV.delegate = self
        searchedHerosCV.dataSource = self
        
        searchedHerosCV.register(SearchedHeroCell.self, forCellWithReuseIdentifier: heroCellId)
        
        NSLayoutConstraint.activate([
            searchedHerosCV.topAnchor.constraint(equalTo: heroSearchBar.bottomAnchor, constant: Layout.standardViewPadding),
            searchedHerosCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            searchedHerosCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            searchedHerosCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Data
    private func searchForHeros(forText: String) {
        displayLoadingView()
        NetworkManager.shared.fetchSearchResults(for: forText) { [weak self] result in
            guard let self = self else { return } 
            self.dismissLoadingView()
            switch result {
            case .success(let heros):
                self.heroResults = heros.results
                
                DispatchQueue.main.async {
                    self.reloadCollectionViewAnimated()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.searchedHerosCV.setEmptyMessage("Search results produced and error. Please refine your search and try again.")
                }
                print("error: \(error)")
            }
        }
    }
    
    //MARK: - Helpers
    
    private func reloadCollectionViewAnimated() {
        UIView.transition(with: self.searchedHerosCV,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.searchedHerosCV.reloadData() })
    }
    
}

//MARK: - Collection View Delegate
extension HeroSearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if heroResults.count == 0 {
            collectionView.setEmptyMessage("Search by Hero name. (Superman, Batman, Black Widow, etc.)")
        } else {
            collectionView.restore()
        }
        return heroResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hero = heroResults[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: heroCellId, for: indexPath as IndexPath) as! SearchedHeroCell
        cell.heroName.text = hero.name
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHeroSearch = heroResults[indexPath.row]
        //drop keyboard responders if open...
        heroSearchBar.resignFirstResponder()
        
        let singleHeroVC = SingleHeroProfileVC()
        singleHeroVC.hero = selectedHeroSearch
        self.navigationController?.pushViewController(singleHeroVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceWidth = self.view.bounds.width
        let width = floor(deviceWidth - (cellPadding * 2))
        let cellSize = CGSize(width: width, height: cellHeight)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellInset, left: cellInset, bottom: cellInset, right: cellInset)
    }
    
    //give the cells a little animation as they scroll
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        cell.alpha = 0.1
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform.identity
            cell.alpha = 1
        }
    }
}

//MARK: - Search Bar Delegate
extension HeroSearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchEntered = searchBar.text {
            if !searchEntered.isEmpty {
                self.searchForHeros(forText: searchEntered)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

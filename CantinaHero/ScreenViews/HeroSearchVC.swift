//
//  HeroSearchVC.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

// View controller that allows a user to search for heroes by name
// display a collection of common searched hero names
// when user selects a common searched hero or triggers a text search, validate and push them to search results controller
//

import UIKit

class HeroSearchVC: HeroMainBackVC {

    //MARK: - Properties
    private let pageHeaderLbl: HeroTitleLabel = {
        let lbl = HeroTitleLabel(textAlignment: .center)
        lbl.text = "Search Hero's by name, or try one of the commonly searched below!"
        return lbl
    }()
    
    //Search bar
    let heroSearchBar = HeroSearchBar(placeholder: "Search Hero's by Name", backgroundImage: UIImage())
    
    //Collection View
    private let heroCellId = "heroCellId"
    private let commonlySearchedCV: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.backgroundColor = .secondarySystemGroupedBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //MARK - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupSearchField()
        setupCommonSearchCV()
        //fetch the commonly search heros data
        getCommonHeroData()
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
    let numberOfColumnsPhone: CGFloat = 2
    let numberOfColumnsPadLandscape: CGFloat = 4
    let numberOfColumnsPadPort: CGFloat = 3
    let cellHeight: CGFloat = 150
    let cellPadding: CGFloat = 15
    let cellInset: CGFloat = 10
    
    private func setupSearchField() {
        view.addSubview(pageHeaderLbl)
        view.addSubview(heroSearchBar)
        
        heroSearchBar.delegate = self
        
        NSLayoutConstraint.activate([
            pageHeaderLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.standardViewPadding),
            pageHeaderLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.standardViewPadding),
            pageHeaderLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.standardViewPadding),
            
            heroSearchBar.topAnchor.constraint(equalTo: pageHeaderLbl.bottomAnchor, constant: Layout.sectionPadding),
            heroSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.standardViewPadding),
            heroSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.standardViewPadding),
            heroSearchBar.heightAnchor.constraint(equalToConstant: Layout.searchBarHeight),
        
        ])
    }
    
    private func setupCommonSearchCV() {
        view.addSubview(commonlySearchedCV)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellInset
        commonlySearchedCV.collectionViewLayout = layout
        commonlySearchedCV.delegate = self
        commonlySearchedCV.dataSource = self
       
        commonlySearchedCV.register(CommonHeroCell.self, forCellWithReuseIdentifier: heroCellId)
        
        NSLayoutConstraint.activate([
            commonlySearchedCV.topAnchor.constraint(equalTo: heroSearchBar.bottomAnchor, constant: Layout.standardViewPadding),
            commonlySearchedCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            commonlySearchedCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            commonlySearchedCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Data
    private var commonHerosFromServer: CommonSearch!
    
    private func getCommonHeroData() {
        self.showLoadingView()
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        session.dataTask(with: URL(string: WebLinks.commonHerosFilePath)!) { (data, response, error) -> Void in
            // Check if data was received successfully
            if let jsonData = data {
                do {
                    let decoder = JSONDecoder()
                    let parsedData = try decoder.decode(CommonSearch.self, from: jsonData)
                    self.commonHerosFromServer = parsedData
                    DispatchQueue.main.async {
                        self.commonlySearchedCV.reloadData()
                        self.dismissLoadingView()
                    }
                } catch {
                    // Something went wrong
                    print("error fetching data")
                    self.dismissLoadingView()
                }
            } else {
                print("error getting json data")
                self.dismissLoadingView()
            }
        }.resume()
    }
    
    
    //MARK: - Helpers
    
    
}

//MARK: - Collection View Delegate
extension HeroSearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if commonHerosFromServer != nil {
            return commonHerosFromServer.common.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hero = commonHerosFromServer.common[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: heroCellId, for: indexPath as IndexPath) as! CommonHeroCell
        cell.name.text = hero.name
        
        if !hero.image_path.isEmpty {
            NetworkManager.shared.downloadImage(from: hero.image_path) { image in
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
        let selectedHeroSearch = commonHerosFromServer.common[indexPath.row]

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns:CGFloat = numberOfColumnsPhone //default 2 columns for phones
        let deviceWidth = self.view.bounds.width

        if UIDevice.current.userInterfaceIdiom == .pad {
            numberOfColumns =  4 //UIWindow.isLandscape ? numberOfColumnsPadLandscape : numberOfColumnsPadPort //use 4 columns for landscape and 3 for portrait
        }

        let width = floor(deviceWidth / numberOfColumns - cellPadding)
        let cellSize = CGSize(width: width, height: cellHeight)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        cell.alpha = 0.1
        UIView.animate(withDuration: 0.3) {
            cell.transform = CGAffineTransform.identity
            cell.alpha = 1
        }
    }
}

//MARK: - Search Bar Delegate
extension HeroSearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

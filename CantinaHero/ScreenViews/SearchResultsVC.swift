//
//  SearchResultsVC.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

import UIKit

class SearchResultsVC: HeroMainBackVC {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
    //    private func getHeros() {
    //        showLoadingView()
    //        NetworkManager.shared.fetchSearchResults(for: "Super") { [weak self] result in
    //            guard let self = self else { return } //unwrap the optional
    //            self.dismissLoadingView()
    //            switch result {
    //            case .success(let heros):
    ////                print("results: \(heros)")
    //                self.featuredHeros = heros.results
    //                DispatchQueue.main.async {
    //                    self.featuredHeroName.text = self.featuredHeros[0].name
    //                    self.featuredHeroShort.text = self.featuredHeros[0].biography.placeOfBirth
    //                    self.featuredCollectionView.reloadData()
    //                }
    //
    //            case .failure(let error):
    //                print("error: \(error)")
    //            }
    //        }
    //    }
    
}

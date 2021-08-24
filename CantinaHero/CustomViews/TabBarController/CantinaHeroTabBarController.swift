//
//  CantinaHeroTabBarController.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

import UIKit

class CantinaHeroTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createHomeNC(), createFavoritesNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = HeroSearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createHomeNC() -> UINavigationController {
        let homeVC = HeroHomeVC()
        homeVC.title = "Featured"
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = HeroFavoritesVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
}


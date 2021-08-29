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
        UITabBar.appearance().tintColor = UIColor.mainThemeColor
        viewControllers = [createSearchNC(), createHomeNC()]
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
    
}


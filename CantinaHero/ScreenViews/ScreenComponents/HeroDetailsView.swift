//
//  HeroDetailsView.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/23/21.
//
// details view for a single hero. displaying all the text data

import UIKit

class HeroDetailsView: UIView {
    
    private var heroData: HeroData!
    
    required init(hero: HeroData) {
        self.heroData = hero
        super.init(frame: .zero)
        self.powerStatsView = PowerStatsView(hero: self.heroData)
        self.setupView()
    }
    
    //Exposed method to allow updating the heroData displayed. 
    public func updateHero(hero: HeroData) {
        self.heroData = hero
        self.name.text = hero.name
        powerStatsView.updateHero(hero: self.heroData)
    }
   
    
    // Name
    private let name = HeroTitleLabel(textAlignment: .left, fontSize: 24)
    
    // power stats
    private var powerStatsView:PowerStatsView!
    
    // appearance
    // bio
    // work
    //connections
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(name)
        addSubview(powerStatsView)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.standardViewPadding),
            name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.standardViewPadding),
            name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.standardViewPadding),
            
            powerStatsView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Layout.standardViewPadding),
            powerStatsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.standardViewPadding),
            powerStatsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.standardViewPadding),
            
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

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
        self.bioView = BiographyView(hero: self.heroData)
        self.setupView()
    }
    
    //Exposed method to allow updating the heroData displayed. 
    public func updateHero(hero: HeroData) {
        self.heroData = hero
        self.name.text = hero.name
        powerStatsView.updateHero(hero: self.heroData)
        bioView.updateHero(hero: self.heroData)
    }
   
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let name = HeroTitleLabel(textAlignment: .left, fontSize: 24)
    private var powerStatsView:PowerStatsView!
    private var bioView:BiographyView!
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.addSubview(mainContainer)
        mainContainer.addSubview(name)
        mainContainer.addSubview(powerStatsView)
        mainContainer.addSubview(bioView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            mainContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            name.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: Layout.standardViewPadding),
            name.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: Layout.standardViewPadding),
            name.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -Layout.standardViewPadding),
            
            powerStatsView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Layout.standardViewPadding),
            powerStatsView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: Layout.standardViewPadding),
            powerStatsView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -Layout.standardViewPadding),
            
            bioView.topAnchor.constraint(equalTo: powerStatsView.bottomAnchor, constant: Layout.standardViewPadding),
            bioView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: Layout.standardViewPadding),
            bioView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -Layout.standardViewPadding),
            bioView.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

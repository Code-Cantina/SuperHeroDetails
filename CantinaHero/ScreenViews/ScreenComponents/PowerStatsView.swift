//
//  PowerStatsView.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/23/21.
//

import UIKit

class PowerStatsView: UIView {
    
    private var heroData: HeroData?
    
    required init(hero: HeroData?) {
        self.heroData = hero
        super.init(frame: .zero)
        self.setupView()
    }
    
    //Exposed method to allow updating the heroData displayed.
    public func updateHero(hero: HeroData) {
        self.heroData = hero
        self.updateHeroUIDetails()
    }
   
    // header
    private let statHeader = HeroBodyLabel(textAlignment: .center)
    
    private let powerStatsValuesStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let intelligence = HeroBodyLabel(textAlignment: .center)
    private let strength = HeroBodyLabel(textAlignment: .center)
    private let speed = HeroBodyLabel(textAlignment: .center)
    private let durability = HeroBodyLabel(textAlignment: .center)
    private let power = HeroBodyLabel(textAlignment: .center)
    private let combat = HeroBodyLabel(textAlignment: .center)
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        statHeader.text = "Power Stats:"
        
        powerStatsValuesStack.addArrangedSubview(intelligence)
        powerStatsValuesStack.addArrangedSubview(strength)
        powerStatsValuesStack.addArrangedSubview(speed)
        powerStatsValuesStack.addArrangedSubview(durability)
        powerStatsValuesStack.addArrangedSubview(power)
        powerStatsValuesStack.addArrangedSubview(combat)
        
        addSubview(statHeader)
        addSubview(powerStatsValuesStack)
        
        NSLayoutConstraint.activate([
            statHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.standardViewPadding),
            statHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.standardViewPadding),
            statHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.standardViewPadding),
            
            powerStatsValuesStack.topAnchor.constraint(equalTo: statHeader.bottomAnchor, constant: Layout.standardViewPadding),
            powerStatsValuesStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            powerStatsValuesStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            powerStatsValuesStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.standardViewPadding)
            
        ])
        self.updateHeroUIDetails()
        
    }
    
    private func updateHeroUIDetails() {
        if let hero = self.heroData {
            self.intelligence.text = "Intelligence: \(hero.powerstats.intelligence)"
            self.strength.text = "Strength: \(hero.powerstats.strength)"
            self.speed.text = "Speed: \(hero.powerstats.speed)"
            self.durability.text = "Durability: \(hero.powerstats.durability)"
            self.power.text = "Power: \(hero.powerstats.power)"
            self.combat.text = "Combat: \(hero.powerstats.combat)"
        }
//        else {
//            self.intelligence.text = ""
//            self.strength.text = ""
//            self.speed.text = ""
//            self.durability.text = ""
//            self.power.text = ""
//            self.combat.text = ""
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

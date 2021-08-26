//
//  PowerStatsView.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/23/21.
//

import UIKit

class PowerStatsView: UIView {
    
    private var heroData: HeroData? //this will be passed in with init
    
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
   
    //MARK: - UI Properties
    private let statHeader: HeroTitleLabel = {
        let lbl = HeroTitleLabel(textAlignment: .left, fontSize: 16)
        lbl.text = "Power Stats:"
        return lbl
    }()
    
    private let powerStatsValuesStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let intelligence = HeroBodyLabel(textAlignment: .left)
    private let strength = HeroBodyLabel(textAlignment: .left)
    private let speed = HeroBodyLabel(textAlignment: .left)
    private let durability = HeroBodyLabel(textAlignment: .left)
    private let power = HeroBodyLabel(textAlignment: .left)
    private let combat = HeroBodyLabel(textAlignment: .left)
    
    //appearance header
    private let appearanceHeader: HeroTitleLabel = {
        let lbl = HeroTitleLabel(textAlignment: .left, fontSize: 16)
        lbl.text = "Appearance:"
        return lbl
    }()
    
    private let appearanceStatsValuesStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let gender = HeroBodyLabel(textAlignment: .left)
    private let race = HeroBodyLabel(textAlignment: .left)
    private let heroHeight = HeroBodyLabel(textAlignment: .left)
    private let heroWeight = HeroBodyLabel(textAlignment: .left)
    private let eyeColor = HeroBodyLabel(textAlignment: .left)
    private let hairColor = HeroBodyLabel(textAlignment: .left)
    
    private let stacksStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - UI Setup
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        powerStatsValuesStack.addArrangedSubview(statHeader)
        
        powerStatsValuesStack.addArrangedSubview(intelligence)
        powerStatsValuesStack.addArrangedSubview(strength)
        powerStatsValuesStack.addArrangedSubview(speed)
        powerStatsValuesStack.addArrangedSubview(durability)
        powerStatsValuesStack.addArrangedSubview(power)
        powerStatsValuesStack.addArrangedSubview(combat)
        
        appearanceStatsValuesStack.addArrangedSubview(appearanceHeader)
        appearanceStatsValuesStack.addArrangedSubview(gender)
        appearanceStatsValuesStack.addArrangedSubview(race)
        appearanceStatsValuesStack.addArrangedSubview(heroHeight)
        appearanceStatsValuesStack.addArrangedSubview(heroWeight)
        appearanceStatsValuesStack.addArrangedSubview(eyeColor)
        appearanceStatsValuesStack.addArrangedSubview(hairColor)
        
        stacksStack.addArrangedSubview(powerStatsValuesStack)
        stacksStack.addArrangedSubview(appearanceStatsValuesStack)
        addSubview(stacksStack)
        
        NSLayoutConstraint.activate([
            stacksStack.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.standardViewPadding),
            stacksStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stacksStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stacksStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.standardViewPadding)
            
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
            
            self.gender.text = "Gender: \(hero.appearance.gender)"
            self.race.text = "Race: \(hero.appearance.race)"
            self.heroHeight.text = "Height: \(hero.appearance.height[0])"
            self.heroWeight.text = "Weight: \(hero.appearance.weight[0])"
            self.eyeColor.text = "Eye Color: \(hero.appearance.eyeColor)"
            self.hairColor.text = "Hair Color: \(hero.appearance.hairColor)"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

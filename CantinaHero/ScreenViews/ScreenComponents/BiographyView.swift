//
//  BiographyView.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/25/21.
//

import UIKit

class BiographyView: UIView {
    
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

    private let bioHeader: HeroTitleLabel = {
        let lbl = HeroTitleLabel(textAlignment: .left, fontSize: 16)
        lbl.text = "Biography: "
        return lbl
    }()
    
    private let fullName = HeroBodyLabel(textAlignment: .left)
    private let alterEgos = HeroBodyLabel(textAlignment: .left)
    private let aliases = HeroBodyLabel(textAlignment: .left)
    private let placeOfBirth = HeroBodyLabel(textAlignment: .left)
    private let firstAppearance = HeroBodyLabel(textAlignment: .left)
    private let publisher = HeroBodyLabel(textAlignment: .left)
    private let alignment = HeroBodyLabel(textAlignment: .left)
    private let occupation = HeroBodyLabel(textAlignment: .left)
    private let base = HeroBodyLabel(textAlignment: .left)
    private let affiliations = HeroBodyLabel(textAlignment: .left)
    private let relatives = HeroBodyLabel(textAlignment: .left)
    
    private let bioStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    //MARK: - UI Setup
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bioHeader)
        
        bioStack.addArrangedSubview(fullName)
        bioStack.addArrangedSubview(alterEgos)
        bioStack.addArrangedSubview(aliases)
        bioStack.addArrangedSubview(placeOfBirth)
        bioStack.addArrangedSubview(firstAppearance)
        bioStack.addArrangedSubview(alignment)
        bioStack.addArrangedSubview(occupation)
        bioStack.addArrangedSubview(base)
        bioStack.addArrangedSubview(affiliations)
        bioStack.addArrangedSubview(relatives)
        
        addSubview(bioStack)
        
        NSLayoutConstraint.activate([
            bioHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.standardViewPadding),
            bioHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bioHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            bioStack.topAnchor.constraint(equalTo: bioHeader.bottomAnchor, constant: Layout.standardViewPadding),
            bioStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bioStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bioStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.standardViewPadding)
            
        ])
        self.updateHeroUIDetails()
    }
    
    //MARK: - Helpers
    private func updateHeroUIDetails() {
        if let hero = self.heroData {
            self.fullName.text = "Full Name: \(hero.biography.fullName)"
            self.alterEgos.text = "Alter Egos: \(hero.biography.alterEgos)"
            self.aliases.text = "Aliases: \(hero.biography.aliases)"
            self.placeOfBirth.text = "Place of Birth: \(hero.biography.placeOfBirth)"
            self.firstAppearance.text = "First Appearance: \(hero.biography.firstAppearance)"
            self.alignment.text = "Alignment: \(hero.biography.alignment)"
            self.occupation.text = "Occupation: \(hero.work.occupation)"
            self.base.text = "Base: \(hero.work.base)"
            self.affiliations.text = "Affiliations: \(hero.connections.groupAffiliation)"
            self.relatives.text = "Relatives: \(hero.connections.relatives)"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SingleHeroProfileVC.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

import UIKit

class SingleHeroProfileVC: UIViewController {
    
    //MARK: - Properties
    var hero: HeroData!
    
    private let pageHeaderLbl = HeroHeaderLabel(text: "")
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: AppImages.defaultHeroImage)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var detailsArea: HeroDetailsView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupUI()
    }
    
    //MARK: - SetupUI
    
    private func setupUI() {
        detailsArea = HeroDetailsView(hero: self.hero)
        pageHeaderLbl.text = self.hero.name
        
        if !hero.image.url.isEmpty {
            NetworkManager.shared.downloadImage(from: hero.image.url) { image in
                DispatchQueue.main.async {
                    self.logoImageView.image = image
                }
            }
        } else {
            self.logoImageView.image = AppImages.defaultHeroImage
        }
        
        self.view.addSubview(pageHeaderLbl)
        self.view.addSubview(logoImageView)
        self.view.addSubview(detailsArea)
        
        NSLayoutConstraint.activate([
            pageHeaderLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Layout.standardViewPadding),
            pageHeaderLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Layout.standardViewPadding),
            pageHeaderLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Layout.standardViewPadding),
            
            logoImageView.topAnchor.constraint(equalTo: pageHeaderLbl.bottomAnchor, constant: Layout.standardViewPadding),
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 140),
            
            detailsArea.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Layout.standardViewPadding),
            detailsArea.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailsArea.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            detailsArea.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.standardViewPadding)
        ])
    }
    
}

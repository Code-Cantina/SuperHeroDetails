//
//  SearchedHeroCell.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/28/21.
//

import UIKit

class SearchedHeroCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let heroImageWidth: CGFloat = 65
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: AppImages.defaultHeroImage)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let heroName = HeroTitleLabel(textAlignment: .left)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //MARK: - Setup
    private func setupUI() {
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.borderWidth = 0.6
        contentView.layer.borderColor = UIColor.mainThemeColor!.cgColor
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        
        containerView.addSubview(logoImageView)
        containerView.addSubview(heroName)
        addSubview(containerView)
    
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Layout.smallBufferPadding),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Layout.smallBufferPadding),
            logoImageView.widthAnchor.constraint(equalToConstant: heroImageWidth),
            logoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Layout.smallBufferPadding),
            
            heroName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Layout.standardViewPadding),
            heroName.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Layout.standardViewPadding),
            heroName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Layout.standardViewPadding),
            heroName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Layout.standardViewPadding)
            
        ])
        
        self.addCellDropShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

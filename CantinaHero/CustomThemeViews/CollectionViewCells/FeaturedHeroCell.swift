//
//  FeaturedHeroCell.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/28/21.
//

import UIKit

class FeaturedHeroCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: AppImages.defaultHeroImage)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //MARK: - Setup
    private func setupUI() {
        containerView.addSubview(logoImageView)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Layout.smallBufferPadding),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Layout.smallBufferPadding),
            logoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Layout.smallBufferPadding),
            logoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Layout.smallBufferPadding)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

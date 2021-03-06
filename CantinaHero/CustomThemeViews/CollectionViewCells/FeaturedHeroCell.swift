//
//  FeaturedHeroCell.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/28/21.
//

import UIKit

class FeaturedHeroCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
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
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
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

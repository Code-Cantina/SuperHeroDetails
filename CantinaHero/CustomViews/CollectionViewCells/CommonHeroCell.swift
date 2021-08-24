//
//  CommonHeroCell.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/21/21.
//

import UIKit

class CommonHeroCell: UICollectionViewCell {
    
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
    
    let name: HeroBodyLabel = {
        let lbl = HeroBodyLabel(textAlignment: .center)
        return lbl
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //MARK: - Setup
    private func setupUI(){
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.borderWidth = 0.6
        contentView.layer.borderColor = UIColor.systemGreen.cgColor
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        
        containerView.addSubview(logoImageView)
        containerView.addSubview(name)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Layout.standardViewPadding),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            logoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            name.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Layout.standardViewPadding),
            name.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Layout.standardViewPadding),
            name.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Layout.standardViewPadding),
            name.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Layout.standardViewPadding),
            
        ])
        
        self.addCellDropShadow()
        
    }
    
    //this fires when the device color mode has changed Light/Dark. We need to force update the shadow color
//    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        //update drop shadow color for ui theme change
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UICollectionViewCell {
    
    func addCellDropShadow() {
        self.layer.shadowColor = UIColor.systemGreen.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 4
    }
}


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
        contentView.backgroundColor = .secondarySystemGroupedBackground
        
        containerView.addSubview(logoImageView)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            logoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2),
            logoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2),
            logoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

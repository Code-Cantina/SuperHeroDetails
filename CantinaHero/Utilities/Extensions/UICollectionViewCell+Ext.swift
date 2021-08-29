//
//  UICollectionViewCell+Ext.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/28/21.
//

import UIKit

extension UICollectionViewCell {
    
    func addCellDropShadow() {
        self.layer.shadowColor = UIColor.mainThemeColor!.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 4
    }
}

extension UICollectionView {
    func setEmptyMessage(_ message: String) {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lbl.text = message
        lbl.textColor = UIColor.mainThemeColor
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 16)
        lbl.sizeToFit()
        self.backgroundView = lbl
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

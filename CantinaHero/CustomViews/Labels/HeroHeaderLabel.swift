//
//  HeroHeaderLabel.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/23/21.
//

import UIKit

class HeroHeaderLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(textAlignment: NSTextAlignment = .left) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    private func setup() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        textColor = UIColor.systemGreen
        font = .boldSystemFont(ofSize: 28)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

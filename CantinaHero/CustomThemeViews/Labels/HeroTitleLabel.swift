//
//  HeroTitleLabel.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/21/21.
//

import UIKit

class HeroTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat = 20) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = .boldSystemFont(ofSize: fontSize)
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    private func setup() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  HeroBodyLabel.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/21/21.
//

import UIKit

class HeroBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
       
    }
    
    convenience init(text:String) {
        self.init()
        self.text = text
    }
    
    private func setup() {
        textColor = UIColor.mainBodyGray
        font = UIFont.systemFont(ofSize: 15)
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

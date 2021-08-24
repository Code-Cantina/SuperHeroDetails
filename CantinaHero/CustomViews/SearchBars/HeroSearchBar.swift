//
//  HeroSearchBar.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/21/21.
//

import UIKit

class HeroSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        self.searchTextField.addTarget(self, action: #selector(didBeganEditing), for: .editingDidBegin)
        self.searchTextField.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
    }

    convenience init(placeholder: String = "", backgroundImage: UIImage? = nil) {
        //setting to empty image removed border lines, unless otherwise needed
        self.init(frame: CGRect.zero)
        self.backgroundImage = backgroundImage
        self.placeholder = placeholder
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = UIColor.systemGreen
    }
    
    @objc func didBeganEditing() {
        self.setShowsCancelButton(true, animated: true)
    }
    @objc func didEndEditing() {
        self.setShowsCancelButton(false, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

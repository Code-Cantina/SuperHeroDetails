//
//  HeroMainBackVC.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

import UIKit

class HeroMainBackVC: UIViewController {

    var containerView: UIView!
    
    func displayLoadingView() {
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(containerView)
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

}

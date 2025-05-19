//
//  Extensions.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 20/05/2025.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setUpConstraints(_ activityIndicator: ActivityIndicatorView) {
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.bringSubviewToFront(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    func startLoading(_ activityIndicator: ActivityIndicatorView) {
        self.view.isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    func finishLoading(_ activityIndicator: ActivityIndicatorView) {
        self.view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    
    func showMessage(title: String? = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

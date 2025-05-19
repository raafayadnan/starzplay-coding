//
//  CustomElements.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation
import UIKit

@IBDesignable
class CustomShadowImageView: UIImageView {
    
    @IBInspectable var startColor: UIColor = UIColor.clear { didSet { updateView() }}
    @IBInspectable var endColor: UIColor = UIColor.clear { didSet { updateView() }}
    
    private var gradientLayer: CAGradientLayer?
    
    private func updateView() {
        // Remove the existing gradient layer if it exists
        gradientLayer?.removeFromSuperlayer()
        
        // Create a new gradient layer
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [0, 1]
        
        // Set the gradient's frame and corner radius
        gradient.frame = bounds
        
        // Add the gradient layer as a sublayer
        layer.addSublayer(gradient)
        
        // Store the reference for future updates/removals
        gradientLayer = gradient
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update the gradient layer frame when the bounds change
        gradientLayer?.frame = bounds
    }
    
    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

@IBDesignable
class CustomImageView: UIImageView {
    
    @IBInspectable var bgColor: UIColor = .systemBackground {didSet{updateView()}}
    @IBInspectable var borderSize: CGFloat = 0.0 {didSet{updateView()}}
    @IBInspectable var borderColor: UIColor = UIColor.clear {didSet{updateView()}}
    @IBInspectable var rounded: Bool = false {didSet{updateView()}}
    
    @IBInspectable var cornorRadius: CGFloat = 0.0 {didSet {updateView()}}
    
    private func updateView() {
        
        layer.borderWidth = borderSize
        layer.borderColor = borderColor.cgColor
        
        backgroundColor = bgColor
        
        layer.cornerRadius = rounded ? (self.frame.size.height / 2) : layer.cornerRadius
        contentMode = .scaleAspectFill
        layer.masksToBounds = !rounded
        clipsToBounds = rounded
        
        if !rounded {
            layer.cornerRadius = cornorRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

@IBDesignable
class CustomControl: UIControl {
    @IBInspectable var bgColor: UIColor = .systemBackground {didSet {updateView()}}
    @IBInspectable var bgColorAlpha: CGFloat = 1.0 {didSet {updateView()}}
    
    @IBInspectable var borderSize: CGFloat = 0.0 {didSet {updateView()}}
    @IBInspectable var borderColor: UIColor = UIColor.clear {didSet {updateView()}}
    
    @IBInspectable var cornorRadius: CGFloat = 0.0 {didSet {updateView()}}
        
    override func layoutSubviews() {
        updateView()
    }
    func updateView() {
                
        layer.borderWidth = borderSize
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornorRadius
        
        backgroundColor = bgColor.withAlphaComponent(bgColorAlpha)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

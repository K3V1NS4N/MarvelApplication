//
//  ShadowView.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 21/10/21.
//

import UIKit

class ShadowView: UIView {
    @IBInspectable
    public var shadowRadius: CGFloat = 16
    @IBInspectable
    public var cornerRadius: CGFloat = 14
    @IBInspectable
    public var shadowOpacity: Float = 0.05
    @IBInspectable
    public var shadowOffset: Int = 14
    
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: shadowOffset)
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
        
    }
}

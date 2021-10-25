//
//  UIView+Extension.swift
//  MarvelApplication
//
//  Created by K3V1NS4N on 21/10/21.
//

import UIKit

extension UIView {
    
    public func roundCorners (corners: [UIRectCorner], radius: CGFloat) {
        var myMaskedCorners: CACornerMask = CACornerMask()
        corners.forEach { (corner) in
            switch corner {
            case .topLeft:
                myMaskedCorners.insert(.layerMinXMinYCorner)
            case .topRight:
                myMaskedCorners.insert(.layerMaxXMinYCorner)
            case .bottomLeft:
                myMaskedCorners.insert(.layerMinXMaxYCorner)
            case .bottomRight:
                myMaskedCorners.insert(.layerMaxXMaxYCorner)
            case .allCorners:
                myMaskedCorners = [.layerMinXMinYCorner,
                                   .layerMaxXMinYCorner,
                                   .layerMinXMaxYCorner,
                                   .layerMaxXMaxYCorner]
            default:break
            }
        }
        self.clipsToBounds =  true
        layer.cornerRadius = radius
        layer.maskedCorners = myMaskedCorners

    }
    
    func addBlur(_ alpha: CGFloat = 1) {
        // create effect
        let effect = UIBlurEffect(style: .prominent)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        self.addSubview(effectView)
    }

    func startShimmeringAnimation(animationSpeed: Float = 2,
                                  repeatCount: Float = MAXFLOAT) {
      
      let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
      let blackColor = UIColor.black.cgColor
      
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [blackColor, lightColor, blackColor]
      gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
      
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.6)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
      
      gradientLayer.locations =  [-1.0, -0.7, -0.5, -0.3, 0.0]
      self.layer.mask = gradientLayer
      
      CATransaction.begin()
      let animation = CABasicAnimation(keyPath: "locations")
      animation.fromValue = [-1.0, -0.7, -0.5, -0.3, 0.0]
      animation.toValue = [1, 1.3, 1.5, 1.7, 2]
      animation.duration = CFTimeInterval(animationSpeed)
      animation.repeatCount = repeatCount
      CATransaction.setCompletionBlock { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.layer.mask = nil
      }
      gradientLayer.add(animation, forKey: "shimmerAnimation")
      CATransaction.commit()
    }
      
      func stopShimmeringAnimation() {
          self.backgroundColor = .clear
          self.layer.mask = nil
      }
    
    // MARK: Programmatically constraints
    func pinLeading(toLeadingOf view: UIView, constant: CGFloat) {
        NSLayoutConstraint(item: view,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: constant).isActive = true
    }
    
    @discardableResult func pinTrailing(toTrailingOf view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .trailing,
                                            multiplier: 1.0,
                                            constant: -constant)
        constraint.isActive = true
        return constraint
    }
    
    func alignHorizontalAxis(toSameAxisOfView view: UIView) {
        NSLayoutConstraint(item: view,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
    }

    @discardableResult func setHeight(to constant: CGFloat, priority: Float =  1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1.0,
                           constant: constant)
        constraint.priority = UILayoutPriority(rawValue: priority)
        constraint.isActive = true
        return constraint
    }
    
}

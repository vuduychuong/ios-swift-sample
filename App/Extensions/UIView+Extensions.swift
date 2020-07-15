//
//  UIView+Extensions.swift
////
//  Created by Chuong Vu Duy on 11/14/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import Foundation
extension UIView {

    //MARK: Gradient background
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]? = nil, direction: [CGPoint]? = nil) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        if nil != direction && direction!.count > 1 {
            gradient.startPoint = direction![0]
            gradient.endPoint = direction![1]
        }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }

    func startShimmeringEffect() {
        let light = UIColor.white.cgColor
        let alpha = UIColor(red: 206/255, green: 10/255, blue: 10/255, alpha: 0.5).cgColor
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.colors = [light, alpha, light]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.525)
        gradient.locations = [0.35, 0.50, 0.65]
        self.layer.mask = gradient
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9,1.0]
        animation.duration = 1.5
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
    func stopShimmeringEffect() {
        self.layer.mask = nil
    }

    func changeBackgroundLeftToRight(color: UIColor) {
        if color.cgColor == self.layer.backgroundColor {
            return
        }
        let layer = CAGradientLayer()
        let startLocations = [0, 0]
        let endLocations = [1, 1]

        layer.colors = [color.cgColor, self.layer.backgroundColor ?? UIColor.white.cgColor  ]
        layer.frame = self.frame
        layer.locations = startLocations as [NSNumber]
        layer.startPoint = CGPoint(x: 0.0, y: 1.0)
        layer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.addSublayer(layer)
        var currentLayers = self.layer.sublayers
        currentLayers?.insert(layer, at: 0)

        let anim = CABasicAnimation(keyPath: "locations")
        anim.fromValue = startLocations
        anim.toValue = endLocations
        anim.duration = 1.0
        layer.add(anim, forKey: "loc")
        layer.locations = endLocations as [NSNumber]
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }


    @objc func bindToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let begginingFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - begginingFrame.origin.y

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
}

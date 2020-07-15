//
//  GradientCard.swift
////
//  Created by Chuong Vu Duy on 7/9/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation

class GradientCard : UIView {
    var shadowView : UIView = UIView()
    var cardView : UIView = UIView()
    var gradientLayer : CAGradientLayer = CAGradientLayer()

    var shadowOpacity : Float = 0.0 {
        didSet {
           shadowView.layer.shadowOpacity = shadowOpacity
        }
    }

    var shadowRadius : CGFloat = 0.0 {
        didSet {
            shadowView.layer.shadowRadius = shadowRadius
        }
    }

    var shadowColor : UIColor? {
        didSet {
            shadowView.layer.shadowColor = shadowColor?.cgColor
        }
    }

    var shadowOffset : CGSize = .zero {
        didSet {
            shadowView.layer.shadowOffset = shadowOffset
        }
    }

    var cornerRadius : CGFloat = 0.0 {
        didSet {
            cardView.layer.cornerRadius = cornerRadius
            shadowView.layer.cornerRadius = cornerRadius
        }
    }

    var gradientColors : [UIColor] = [UIColor.white] {
        didSet {
            var cgColors : [CGColor] = []
            //get cgColor from each
            for color in gradientColors {
                cgColors.append(color.cgColor)
            }
            gradientLayer.colors = cgColors
        }
    }

    func setup() {
        self.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        shadowView.backgroundColor = UIColor.white

        self.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cardView.backgroundColor = UIColor.white

        self.sendSubviewToBack(cardView)
        self.sendSubviewToBack(shadowView)

        cardView.clipsToBounds = true
        cardView.layer.insertSublayer(gradientLayer, at: 0)

        self.backgroundColor = UIColor.clear
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()

    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientLayer.frame = cardView.bounds
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.locations = [0, 1]
    }
}

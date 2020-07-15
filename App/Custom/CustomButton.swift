//
//  CustomButton.swift
////
//  Created by Chuong Vu Duy on 12/23/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

class CustomButton: UIButton {
}

class LightButton: CustomButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.greyishBrown.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        setTitleColorState(normal: UIColor.greyishBrown, selected: UIColor.greyishBrown.withAlphaComponent(0.5))
    }

}

class LightButtonBorderLess: CustomButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
        self.clipsToBounds = true
        setTitleColorState(normal: UIColor.aquaBlue, selected: UIColor.aquaBlue.withAlphaComponent(0.5))
    }

}

class DarkButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.backgroundColor = UIColor.greyishBrown
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
        self.clipsToBounds = true
        setTitleColorState(normal: UIColor.aquaBlue, selected: UIColor.aquaBlue.withAlphaComponent(0.5))
    }
}

class GradientButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        applyGradient(colours: [UIColor.tealish, UIColor.dark_sky_blue], direction: [CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5)])
        self.layer.borderWidth = 0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        setTitleColorState(normal: UIColor.white, selected: UIColor.white.withAlphaComponent(0.7))
    }
}

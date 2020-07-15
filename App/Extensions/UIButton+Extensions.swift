//
//  UIButton+Extensions.swift
////
//  Created by Chuong Vu Duy on 3/25/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation

extension UIButton {
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }

    func setImageState(normal: UIImage, selected: UIImage, disable: UIImage? = nil) {
        setImage(normal, for: .normal)
        setImage(selected, for: .highlighted)
        setImage(selected, for: .selected)
        if nil == disable {
            setImage(selected, for: .disabled)
        } else {
            setImage(disable, for: .disabled)
        }
    }

    //TODO: Create UIImage from UIColor
//    func setBackgroundState(normal: UIColor, selected: UIColor, disable: UIColor? = nil) {
//        setImageState(normal: UIImage.image(with: normal), selected: UIImage.image(with: selected), disable: disable == nil ? nil : UIImage.image(with: disable!))
//    }

    func setTitleColorState(normal: UIColor, selected: UIColor, disable: UIColor? = nil) {
        setTitleColor(normal, for: .normal)
        setTitleColor(selected, for: .highlighted)
        setTitleColor(selected, for: .selected)
        if nil == disable {
            setTitleColor(selected, for: .disabled)
        } else {
            setTitleColor(disable, for: .disabled)
        }

    }
}

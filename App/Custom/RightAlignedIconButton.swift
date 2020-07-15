//
//  RightAlignedIconButton.swift
////
//  Created by Chuong Vu Duy on 12/12/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import Foundation
@IBDesignable
class RightAlignedIconButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth)
    }
}

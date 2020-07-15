//
//  ChannelDetailProtocol.swift
////
//  Created by Chuong Vu Duy on 6/5/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
import UIKit
import Domain
import ABLoaderView

protocol ChannelDetailProtocol {

    //MARK: Shimmer
    func startShimmer()

    func stopShimmer()

    func getViewsShimmer() -> [UIView]
}

extension ChannelDetailProtocol {

    func startShimmer() {
        let arrayView = self.getViewsShimmer()
        for item in arrayView {
            ABLoader().startShining(item)
        }
    }

    func stopShimmer() {
        let arrayView = self.getViewsShimmer()
        for item in arrayView {
            ABLoader().stopShining(item)
        }
    }

    func getViewsShimmer() -> [UIView] {
        fatalError(String(format: "You need override getViewsShimmer() function on %@", String(describing: self)))
    }

    func createConstraint(firstItem: UIView, secondItem: UIView) -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: firstItem, attribute: .top, relatedBy: .equal, toItem: secondItem, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: firstItem, attribute: .bottom, relatedBy: .equal, toItem: secondItem, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: firstItem, attribute: .leading, relatedBy: .equal, toItem: secondItem, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: firstItem, attribute: .trailing, relatedBy: .equal, toItem: secondItem, attribute: .trailing, multiplier: 1, constant: 0)
        return [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
    }
}

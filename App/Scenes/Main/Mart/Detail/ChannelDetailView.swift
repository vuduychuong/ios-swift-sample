//
//  ChannelDetailView.swift
//  App
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
import Domain
import ABLoaderView

protocol ChannelDetailView: ViewControllerProtocol {

    func bindData(_ item: ChannelEntity)

    //MARK: Shimmer
    func startShimmer()

    func stopShimmer()

    func getViewsShimmer() -> [UIView]
}


extension ChannelDetailView {

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
}

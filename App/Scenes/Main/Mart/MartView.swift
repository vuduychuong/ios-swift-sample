//
//  MartView.swift
//  App
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
import Domain

protocol MartView: ViewControllerProtocol {
    func attachChannelPages(categoryList: [CategoryEntity])
}

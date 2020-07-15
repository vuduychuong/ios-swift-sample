//
//  EventViewModel.swift
//  thepol
//
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    private let navigator: HomeNavigator

    init(navigator: HomeNavigator) {
        self.navigator = navigator
    }

    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
        return Output()
    }
}

extension HomeViewModel {
    struct Input {
    }

    struct Output {
    }
}


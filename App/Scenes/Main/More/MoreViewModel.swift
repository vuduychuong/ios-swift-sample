//
//  MoreViewModel.swift
////
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit

class MoreViewModel: ViewModelType {
    let navigator: MoreNavigator

    init(navigator: MoreNavigator) {
        self.navigator = navigator
    }

    func transform(input: MoreViewModel.Input) -> MoreViewModel.Output {
        return Output()
    }
}

extension MoreViewModel {
    struct Input {
    }

    struct Output {
    }
}

//
//  ChannelViewModel.swift
//
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit

class ChannelViewModel: ViewModelType {
    private let navigator: ChannelNavigator

    init(navigator: ChannelNavigator) {
        self.navigator = navigator
    }

    func transform(input: ChannelViewModel.Input) -> ChannelViewModel.Output {
        return Output()
    }
}

extension ChannelViewModel {
    struct Input {
    }

    struct Output {
    }
}

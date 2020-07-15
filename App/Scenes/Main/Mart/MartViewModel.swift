//
//  MartViewModel.swift
//
//  Created by Chuong Vu Duy on 10/24/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import NetworkPlatform

class MartViewModel: ViewModelType {
    let network: Domain.UseCaseProvider
    let useCase: Domain.MartUseCase
    private let disposeBag = DisposeBag()

    let navigator: MartNavigator
    var view: MartView?

    init(navigator: MartNavigator) {
        network = NetworkPlatform.UseCaseProvider()
        useCase = network.makeMartUseCase(token: "")
        self.navigator = navigator
    }
    
    func transform(input: MartViewModel.Input) -> MartViewModel.Output {
        return Output(
        )
    }

    func bindView(_ view: MartView) {
        self.view = view
        if isNetworkConnected() {
            requestChannelCategory()
        }
    }

    private func requestChannelCategory() {
        self.view?.showLoading()
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        self.useCase.getChannelCategory(parameters: [:])

        .trackActivity(activityIndicator)
        .trackError(errorTracker)
        .asDriverOnErrorJustComplete()
        .drive(onNext: { apiResult in
            switch apiResult {
            case .success(let data):
                guard CODE_SUCCESS == data.code else {
                    self.view?.hideLoading()
                    self.view?.showWarning(title: "mart_warning_title".localized, content: data.codeMsg ?? "")
                    return
                }
                guard let categoryList = data.dataArray else {
                    self.view?.hideLoading()
                    return
                }
                self.view?.attachChannelPages(categoryList: categoryList)
                self.view?.hideLoading()
                break
            case .failure(let error):
                self.view?.hideLoading()
                self.view?.showWarning(title: "mart_warning_title".localized, content: error.details ?? "")
                break
            } })
        .disposed(by: disposeBag)
    }
}

extension MartViewModel {
    struct Input {
    }
    
    struct Output {
    }
}


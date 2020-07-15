//
//  ChannelDetailViewModel.swift
////
//  Created by Chuong Vu Duy on 10/27/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import NetworkPlatform

class ChannelDetailViewModel: ViewModelType {
    let network: Domain.UseCaseProvider
    let useCase: Domain.MartUseCase
    private let disposeBag = DisposeBag()

    let navigator: ChannelDetailNavigator
    let channelId: String
    var memberId: String
    var view: ChannelDetailView?

    init(navigator: ChannelDetailNavigator, channelId: String) {
        network = NetworkPlatform.UseCaseProvider()
        useCase = network.makeMartUseCase(token: "")
        self.navigator = navigator
        self.channelId = channelId
        self.memberId = UserDefaultsHelper.getUserToken()
    }

    func transform(input: Input) -> Output {
        return Output()
    }

    func bindView(_ view: ChannelDetailView) {
        self.view = view
        requestChannelDetail()
    }

    private func requestChannelDetail() {
        self.view?.showLoading()
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        self.useCase.getChannelDetail(parameters: ["member_idx" : memberId,
                                                 "board_idx" : channelId])
        .trackActivity(activityIndicator)
        .trackError(errorTracker)
        .asDriverOnErrorJustComplete()
        .drive(onNext: { apiResult in
            switch apiResult {
            case .success(let data):
                guard CODE_SUCCESS == data.code else {
                    self.view?.hideLoading()
                    self.view?.showWarning(title: "channel_detail_warning_title".localized, content: data.codeMsg ?? "")
                    return
                }
                self.view?.bindData(data)
                self.view?.hideLoading()
                break
            case .failure(let error):
                self.view?.hideLoading()
                self.view?.showWarning(title: "channel_detail_warning_title".localized, content: error.details ?? "")
                break
            } })
        .disposed(by: disposeBag)
    }

}

extension ChannelDetailViewModel {
    struct Input {
        let trigger: Driver<Void>
    }

    struct Output {
    }
}


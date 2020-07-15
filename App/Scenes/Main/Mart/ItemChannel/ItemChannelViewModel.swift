//
//  ItemChannelViewModel.swift
//  App
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import NetworkPlatform

class ItemChannelViewModel: ViewModelType {
    let network: Domain.UseCaseProvider
    let useCase: Domain.MartUseCase
    private let disposeBag = DisposeBag()

    let navigator: ItemChannelNavigator
    let categoryId: String
    var view: ItemChannelView?
    var memberId: String
    var pageNum: String?
    var channelList: [ChannelEntity] = []

    init(navigator: ItemChannelNavigator, categoryId: String) {
        network = NetworkPlatform.UseCaseProvider()
        useCase = network.makeMartUseCase(token: "")
        self.navigator = navigator
        self.categoryId = categoryId
        self.memberId = UserDefaultsHelper.getUserToken()
        self.pageNum = "1"
    }

    func transform(input: ItemChannelViewModel.Input) -> ItemChannelViewModel.Output {
        return Output(
        )
    }

    func bindView(_ view: ItemChannelView) {
        self.view = view
        if isNetworkConnected() {
            requestChannelList()
        }
    }

    func openChannelDetail(_ item: ChannelEntity) {
        self.navigator.openChannelDetail(item)
    }

    private func requestChannelList() {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        self.useCase.getChannelList(parameters: ["member_idx" : memberId,
                                                 "page_num" : pageNum ?? "1",
                                                 "category_idx" : categoryId])
        .trackActivity(activityIndicator)
        .trackError(errorTracker)
        .asDriverOnErrorJustComplete()
        .drive(onNext: { apiResult in
            switch apiResult {
            case .success(let data):
                guard CODE_SUCCESS == data.code else {
                    self.view?.showWarning(title: "item_channel_warning_title".localized, content: data.codeMsg ?? "")
                    return
                }
                guard let channelList = data.dataArray else {
                    return
                }
                self.channelList.removeAll()
                self.channelList.append(contentsOf: channelList)
                self.view?.refreshChannelList()
                break
            case .failure(let error):
                self.view?.showWarning(title: "item_channel_warning_title".localized, content: error.details ?? "")
                break
            } })
        .disposed(by: disposeBag)
    }
}

extension ItemChannelViewModel {
    struct Input {
    }

    struct Output {
    }
}


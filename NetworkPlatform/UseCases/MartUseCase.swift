//
//  MartUseCase.swift
//  NetworkPlatform
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class MartUseCase: Domain.MartUseCase {


    private let network: MartNetwork

    init(network: MartNetwork) {
        self.network = network
    }

    func getChannelCategory(parameters: [String : Any]) -> Observable<ApiResult<ChannelCategoryEntity, ApiErrorMessage>> {
        return network.getChannelCategory(parameters: parameters)
    }

    func getChannelList(parameters: [String : Any]) -> Observable<ApiResult<ChannelListResponse, ApiErrorMessage>> {
        return network.getChannelList(parameters: parameters)
    }

    func getChannelDetail(parameters: [String : Any]) -> Observable<ApiResult<ChannelEntity, ApiErrorMessage>> {
        return network.getChannelDetail(parameters: parameters)
    }
}

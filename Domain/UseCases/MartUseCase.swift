//
//  MartUseCase.swift
//  Domain
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
import RxSwift

public protocol MartUseCase {

    func getChannelCategory(parameters: [String: Any]) -> Observable<ApiResult<ChannelCategoryEntity, ApiErrorMessage>>

    func getChannelList(parameters: [String: Any]) -> Observable<ApiResult<ChannelListResponse, ApiErrorMessage>>

    func getChannelDetail(parameters: [String: Any]) -> Observable<ApiResult<ChannelEntity, ApiErrorMessage>>
}

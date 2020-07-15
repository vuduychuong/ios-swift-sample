//
//  UserUseCase.swift
//  NetworkPlatform
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class UserUseCase: Domain.UserUseCase {


    private let network: UserNetwork

    init(network: UserNetwork) {
        self.network = network
    }

    func login(parameters: [String : Any]) -> Observable<ApiResult<UserEntity, ApiErrorMessage>> {
        return network.login(parameters: parameters)
    }
}

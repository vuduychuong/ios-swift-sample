//
//  UserNetwork.swift
//  NetworkPlatform
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Domain
import RxSwift

public final class UserNetwork {
    private let network: Network

    init(network: Network) {
        self.network = network
    }

    public func login(parameters: [String: Any]) -> Observable<ApiResult<UserEntity, ApiErrorMessage>> {
        return network.postItem("/login_v_1_0_0/member_login", parameters: parameters, body: "")
    }
}

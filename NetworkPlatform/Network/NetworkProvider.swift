//
//  NetworkProvider.swift
////
//  Created by Chuong Vu Duy on 16.03.17.
//  Copyright © 2017 METADIUM. All rights reserved.
//

import Domain

#if DEBUG_COMMERCIAL
let URL_ENDPOINT = "http://dev-api.martjangbogo.com"
#else
let URL_ENDPOINT = "http://dev-api.martjangbogo.com"
#endif

final class NetworkProvider {

    public func makeUserNetwork(token: String?) -> UserNetwork {
        let network = Network(URL_ENDPOINT, token: token)
        return UserNetwork(network: network)
    }

    public func makeMartNetwork(token: String?) -> MartNetwork {
        let network = Network(URL_ENDPOINT, token: token)
        return MartNetwork(network: network)
    }
}

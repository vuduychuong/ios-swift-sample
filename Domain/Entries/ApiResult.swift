//
//  ApiResult.swift
//  NetworkPlatform
//
//  Created by Chuong Vu Duy on 11/27/19.
//  Copyright © 2019 METADIUM. All rights reserved.
//
import RxSwift

public enum ApiResult<Value, Error>{
    case success(Value)
    case failure(Error)

    init(value: Value){
        self = .success(value)
    }

    init(error: Error){
        self = .failure(error)
    }
}

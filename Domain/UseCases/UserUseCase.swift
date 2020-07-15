//
//  UserUseCase.swift
//  Domain
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserUseCase {

    func login(parameters: [String: Any]) -> Observable<ApiResult<UserEntity, ApiErrorMessage>>
}

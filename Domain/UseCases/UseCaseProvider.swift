//
//  UseCaseProvider.swift
////
//  Created by Chuong Vu Duy on 18/02/2017.
//  Copyright © 2017 METADIUM. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {

    func makeUserUseCase(token: String) -> UserUseCase

    func makeMartUseCase(token: String) -> MartUseCase
}

//
//  LoginTests.swift
//  AppTests
//
//  Created by Chuong Vu Duy on 7/16/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import XCTest
@testable import App

class LoginTests: XCTestCase {
    var vm: LoginViewModel?

    override func setUpWithError() throws {
        vm = LoginViewModel(navigator: LoginNavigator(navigationController: UINavigationController()))
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    //MARK: UserName
    func testUserNameNotEmpty() throws {
        let userNameEmpty = ""
        XCTAssertEqual(vm?.validUserName(userName: userNameEmpty), "login_user_name_not_empty".localized)
    }

    func testUserNameNotValidFormat() throws {
        let userNameInvalid = "tttttttt"
        XCTAssertEqual(vm?.validUserName(userName: userNameInvalid), "login_user_name_not_valid".localized)
    }

    func testUserNameSuccess() throws {
        let userName = "example@gmail.com"
        XCTAssertEqual(vm?.validUserName(userName: userName), "")
    }

    //MARK: Password
    func testPasswordNotEmpty() throws {
        let passwordEmpty = ""
        XCTAssertEqual(vm?.validPassword(password: passwordEmpty), "login_password_not_empty".localized)
    }

    func testPasswordSuccess() throws {
        let password = "Aa@123456"
        XCTAssertEqual(vm?.validPassword(password: password), "")
    }

}

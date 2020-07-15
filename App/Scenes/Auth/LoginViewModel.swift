//
//  LoginViewModel.swift
//  App
//
//  Created by Chuong Vu Duy on 7/14/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain
import NetworkPlatform

class LoginViewModel: ViewModelType {
    let networkUseCaseProvider: Domain.UseCaseProvider
    let useCase: Domain.UserUseCase
    private let disposeBag = DisposeBag()

    private let navigator: LoginNavigator
    private var view: LoginView?

    init(navigator: LoginNavigator) {
        networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
        useCase = networkUseCaseProvider.makeUserUseCase(token: UserDefaultsHelper.getUserToken())
        self.navigator = navigator
    }

    func transform(input: LoginViewModel.Input) -> LoginViewModel.Output {
        return Output()
    }

    func bindView(view: LoginView) {
        self.view = view
    }

    func login(userName: String?, password: String?) {
        //Valid Username
        let userError = validUserName(userName: userName)
        if !userError.isEmpty {
            self.view?.showWarning(title: "login_user_warning_title".localized, content: userError)
            return
        }
        //Valid password
        let passError = validPassword(password: password)
        if !passError.isEmpty {
            self.view?.showWarning(title: "login_password_warning_title".localized, content: passError)
            return
        }
        if isNetworkConnected() {
            requestLogin(userName: userName!, password: password!)
        }
    }

    private func requestLogin(userName: String, password: String) {
        self.view?.showLoading()
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        self.useCase.login(parameters: ["member_id" : userName,
                                        "member_pw" : password,
                                        "gcm_key" : "2",
                                        "device_os" : "I"])

            .trackActivity(activityIndicator)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
            .drive(onNext: { apiResult in
                switch apiResult {
                case .success(let data):
                    guard CODE_SUCCESS == data.code else {
                        self.view?.hideLoading()
                        self.view?.showWarning(title: "login_warning_title".localized, content: data.codeMsg ?? "")
                        return
                    }
                    guard let token = data.memberIdX else {
                        self.view?.hideLoading()
                        return
                    }
                    UserDefaultsHelper.setUserToken(token: token)
                    self.view?.openMainScreen()
                    self.view?.hideLoading()
                    break
                case .failure(let error):
                    self.view?.hideLoading()
                    self.view?.showWarning(title: "login_warning_title".localized, content: error.details ?? "")
                    break
                } })
            .disposed(by: disposeBag)
    }

    func validUserName(userName: String?) -> String {
        guard !userName!.isEmpty else {
            return "login_user_name_not_empty".localized
        }
        if !MetaUtils.checkValidEmail(userName) {
            return "login_user_name_not_valid".localized
        }
        return ""
    }

    func validPassword(password: String?) -> String {
        guard !password!.isEmpty else {
            return "login_password_not_empty".localized
        }
        return ""
    }
}

extension LoginViewModel {
    struct Input {
    }

    struct Output {
    }
}


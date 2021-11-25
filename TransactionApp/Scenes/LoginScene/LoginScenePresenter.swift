//
//  LoginScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

final class LoginScenePresenter {
    weak var viewController: LoginScenePresenterOutput?
}


// MARK: - LoginScenePresenterInput
extension LoginScenePresenter: LoginScenePresenterInput{
    func presentLogin(response: LoginSceneDataModel.Response) {
        self.viewController?.dispayLoginSuccess(messgae: response.token!)
    }
    func presentLogin(error: LoginSceneDataModel.Error) {
        self.viewController?.displayLoginFailed(message: error.error)
    }
}



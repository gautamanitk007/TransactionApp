//
//  LoginScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

final class LoginScenePresenter {
    weak var viewController: LoginSceneDisplayLogic?
}


// MARK: - LoginScenePresenterInput
extension LoginScenePresenter: LoginScenePresentationLogic{
    func presentLogin(response: LoginSceneDataModel.Response) {
        let viewModel = LoginSceneDataModel.ViewModel(message: "", token: response.token, error: nil)
        self.viewController?.dispayLoginSuccess(viewModel: viewModel)
    }
    func presentLogin(error: LoginSceneDataModel.Error) {
        let viewModel = LoginSceneDataModel.ViewModel(message: "", token: nil, error: error.error)
        self.viewController?.displayLoginFailed(viewModel: viewModel)
    }
}



//
//  LoginScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

typealias LoginScenePresenterInput = LoginSceneInteractorOutput
typealias LoginScenePresenterOutput = LoginSceneViewControllerInput

final class LoginScenePresenter {
    weak var viewController: LoginScenePresenterOutput?
}


// MARK: - LoginScenePresentationLogic
extension LoginScenePresenter: LoginScenePresenterInput{
    func logingSuccess() {
        self.viewController?.loginSuccess()
    }
    
    func logingFailed(message: String) {
        self.viewController?.loginFailed(message: message)
    }
}



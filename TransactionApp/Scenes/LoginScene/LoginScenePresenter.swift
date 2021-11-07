//
//  LoginScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol LoginScenePresentationLogic {
    func didFinishLoginReponse( error: String?)
}

final class LoginScenePresenter {
    
    private weak var viewController: LoginSceneDisplayLogic?
    
    init(viewController: LoginSceneDisplayLogic?) {
        self.viewController = viewController
    }
}


// MARK: - LoginScenePresentationLogic
extension LoginScenePresenter: LoginScenePresentationLogic {
    func didFinishLoginReponse( error: String?){
        if let errorValue = error {
            self.viewController?.loginFailed(message: errorValue)
        } else {
            self.viewController?.loginSuccess()
        }
    }
}



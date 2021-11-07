//
//  LoginScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation

protocol LoginScenePresentationLogic {
    func didFinishLoginReponse(_ response: LoginSceneModel.Response)
    
}

final class LoginScenePresenter {
    
    private weak var viewController: LoginSceneDisplayLogic?
    
    init(viewController: LoginSceneDisplayLogic?) {
        self.viewController = viewController
    }
}


// MARK: - LoginScenePresentationLogic
extension LoginScenePresenter: LoginScenePresentationLogic {
    func didFinishLoginReponse(_ response: LoginSceneModel.Response){
        if let error = response.error {
            self.viewController?.loginFailed(message: error)
        } else if let token = response.token {
            self.viewController?.loginSuccess(token: token)
        }
    }
}



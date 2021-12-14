//
//  RegisterScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 14/12/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

final class RegisterScenePresenter {
  weak var viewController: RegisterSceneDisplayLogic?
}

extension RegisterScenePresenter:RegisterScenePresentationLogic{
    
    func presentRegister(response: RegisterScene.Response) {
        if let token = response.token{
            let viewModel = RegisterScene.RegisterViewModel(token: token)
            self.viewController?.displayRegisterSuccess(viewModel: viewModel)
        } else {
            let errorViewModel = RegisterScene.ErrorViewModel(error: Utils.getLocalisedValue(key:"Unkown"))
            self.viewController?.displayRegisterFailed(errorViewModel: errorViewModel)
        }
    }
    
    func presentRegister(error: ApiError) {
        if let error = error.message {
            let errorViewModel = RegisterScene.ErrorViewModel(error: error)
            self.viewController?.displayRegisterFailed(errorViewModel: errorViewModel)
        } else {
            let errorViewModel = RegisterScene.ErrorViewModel(error: Utils.getLocalisedValue(key:"Unkown"))
            self.viewController?.displayRegisterFailed(errorViewModel: errorViewModel)
        }
    }
}

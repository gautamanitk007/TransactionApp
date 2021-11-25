//
//  LoginSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

final class LoginSceneInteractor {
    var presenter: LoginScenePresenterInput?
    var service: ServiceProtocol?
}

// MARK: - LoginSceneBusinessLogic
extension LoginSceneInteractor: LoginSceneInteractorInput {

    func startLogin(request: LoginSceneDataModel.Request) {
        if request.username == nil || request.username?.count == 0 {
            let loginError = LoginSceneDataModel.Error(error: Utils.getLocalisedValue(key:"UserName_Empty"))
            self.presenter?.presentLogin(error: loginError)
            return
        }
        if request.password == nil || request.password?.count == 0 {
            let loginError = LoginSceneDataModel.Error(error: Utils.getLocalisedValue(key:"Password_Empty"))
            self.presenter?.presentLogin(error: loginError)
            return
        }
        DispatchQueue.global().async {
            self.service?.startLogin(request: request, on: { (response,error) in
                if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue {
                    let loginError = LoginSceneDataModel.Error(error: errorValue.message!)
                    self.presenter?.presentLogin(error: loginError)
                } else if let resp = response, let token = resp.token {
                    TransactionManager.shared.token = token
                    self.presenter?.presentLogin(response: resp)
                }
            })
        }
    }
}

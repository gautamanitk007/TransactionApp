//
//  LoginSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

typealias LoginSceneInteractorInput = LoginSceneViewControllerOutput

protocol LoginSceneInteractorOutput:AnyObject {
    func logingSuccess()
    func logingFailed(message: String)
}

final class LoginSceneInteractor {
    var presenter: LoginScenePresenterInput?
    var service: ServiceProtocol?
}


// MARK: - LoginSceneBusinessLogic
extension LoginSceneInteractor: LoginSceneInteractorInput {

    func startLogin(user userModel: UserModel) {
        if userModel.username == nil || userModel.username?.count == 0 {
            self.presenter?.logingFailed(message: Utils.getLocalisedValue(key:"UserName_Empty"))
            return
        }
        if userModel.password == nil || userModel.password?.count == 0 {
            self.presenter?.logingFailed(message:Utils.getLocalisedValue(key:"Password_Empty"))
            return
        }
        self.service?.startLogin(user: userModel, on: { (response,error) in
            if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue {
                self.presenter?.logingFailed(message: errorValue.message!)
            } else if let tokenObj = response, let token = tokenObj.token {
                TransactionManager.shared.token = token
                self.presenter?.logingSuccess()
            }
        })
    }
}

//
//  LoginSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

typealias LoginSceneInteractable = LoginSceneBusinessLogic

protocol LoginSceneBusinessLogic {
    func startLogin(user userModel: UserModel)
}

final class LoginSceneInteractor {
    
    private var presenter: LoginScenePresentationLogic
    private var service: ServiceProtocol?
    
    init(viewController: LoginSceneDisplayLogic?, apiService: ServiceProtocol) {
        self.presenter = LoginScenePresenter(viewController: viewController)
        self.service = apiService
    }
}


// MARK: - LoginSceneBusinessLogic
extension LoginSceneInteractor: LoginSceneBusinessLogic {
    func startLogin(user userModel: UserModel) {
        if userModel.username == nil || userModel.username?.count == 0 {
            self.presenter.didFinishLoginReponse(error: NSLocalizedString("UserName_Empty",comment: ""))
            return
        }
        if userModel.password == nil || userModel.password?.count == 0 {
            self.presenter.didFinishLoginReponse(error:NSLocalizedString("Password_Empty",comment: ""))
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            guard let self = self else { return }
            self.service?.startLogin(user: userModel, on: { (response,error) in
                if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue {
                    self.presenter.didFinishLoginReponse(error: errorValue.message)
                } else if let tokenObj = response, let token = tokenObj.token {
                    Utils.saveInDefaults(value: token, forKey: "token")
                    self.presenter.didFinishLoginReponse(error: nil)
                }
            })
        }
    }
}

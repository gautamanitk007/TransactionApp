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
        guard userModel.username?.count != 0 else {
            self.presenter.didFinishLoginReponse(LoginSceneModel.Response(token: nil, error: NSLocalizedString("UserName_Empty",comment: "")))
            return
        }
        guard userModel.password?.count != 0 else {
            self.presenter.didFinishLoginReponse(LoginSceneModel.Response(token: nil, error: NSLocalizedString("Password_Empty",comment: "")))
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            guard let self = self else { return }
            self.service?.startLogin(user: userModel, on: { (response) in
                switch response {
                case .Success(let tokenObj):
                    self.presenter.didFinishLoginReponse(LoginSceneModel.Response(token: tokenObj.token,error: nil))
                case .Failure(let error, _):
                    self.presenter.didFinishLoginReponse(LoginSceneModel.Response(token: nil, error: error.description))
                }
            })
        }
    }
}

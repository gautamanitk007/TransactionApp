//
//  RegisterSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 14/12/21.


import UIKit

final class RegisterSceneInteractor {
    var presenter: RegisterScenePresentationLogic?
    var worker: ServiceProtocol?
    init() {
        worker = APIService(APIManager())
    }
}

extension RegisterSceneInteractor: RegisterSceneBusinessLogic{
    func registerUser(request: RegisterScene.Request?) {
        DispatchQueue.global().async {
            self.worker?.registerUser(request: request!, on: {[weak self](response, error) in
                guard let self = self else{ return}
                if let responseObj = response {
                    self.presenter?.presentRegister(response: responseObj)
                } else {
                    self.presenter?.presentRegister(error: error!)
                }
            })
        }
    }
}

//
//  RegisterSceneProtocols.swift
//  TransactionApp
//
//  Created by Gautam Singh on 14/12/21.
//

import Foundation
protocol RegisterSceneDisplayLogic: AnyObject {
    func displayRegisterSuccess(viewModel: RegisterScene.RegisterViewModel)
    func displayRegisterFailed(errorViewModel: RegisterScene.ErrorViewModel)
}

protocol RegisterScenePresentationLogic:AnyObject{
    func presentRegister(response: RegisterScene.Response)
    func presentRegister(error: ApiError)
}

protocol RegisterSceneBusinessLogic:AnyObject{
    func registerUser(request: RegisterScene.Request?)
}


protocol RegisterSceneRoutingLogic:Failure {
    func showDashboard()
}

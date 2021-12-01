//
//  LoginSceneProtocols.swift
//  TransactionApp
//
//  Created by Gautam Singh on 25/11/21.
//

import Foundation

protocol LoginSceneDisplayLogic: AnyObject {
    func dispayLoginSuccess(viewModel:LoginSceneDataModel.ViewModel)
    func displayLoginFailed(viewModel:LoginSceneDataModel.ViewModel)
}

protocol LoginSceneBusinessLogic: AnyObject {
    func startLogin(request: LoginSceneDataModel.Request)
}

protocol LoginScenePresentationLogic: AnyObject {
    func presentLogin(response: LoginSceneDataModel.Response)
    func presentLogin(error: LoginSceneDataModel.Error)
}

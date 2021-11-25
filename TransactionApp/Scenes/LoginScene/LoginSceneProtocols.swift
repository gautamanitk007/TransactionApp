//
//  LoginSceneProtocols.swift
//  TransactionApp
//
//  Created by Gautam Singh on 25/11/21.
//

import Foundation

protocol LoginSceneViewControllerInput: AnyObject {
    func dispayLoginSuccess(viewModel:LoginSceneDataModel.ViewModel)
    func displayLoginFailed(viewModel:LoginSceneDataModel.ViewModel)
}

protocol LoginSceneViewControllerOutput: AnyObject {
    func startLogin(request: LoginSceneDataModel.Request)
}

protocol LoginSceneInteractorOutput: AnyObject {
    func presentLogin(response: LoginSceneDataModel.Response)
    func presentLogin(error: LoginSceneDataModel.Error)
}

typealias LoginSceneInteractorInput = LoginSceneViewControllerOutput
typealias LoginScenePresenterInput = LoginSceneInteractorOutput
typealias LoginScenePresenterOutput = LoginSceneViewControllerInput

//
//  APIProtocol.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation

public protocol ServiceProtocol {
    func registerUser(request:RegisterScene.Request, on completion:@escaping(RegisterScene.Response?,ApiError?)->())
    func startLogin(request:LoginSceneDataModel.Request, on completion:@escaping(LoginSceneDataModel.Response?,ApiError?)->())
    func checkBalances(on completion: @escaping(DashboardSceneDataModel.BalanceResponse?,ApiError?)->())
    func getAllPayee(on completion: @escaping(TransferSceneDataModel.PayeeResponse?,ApiError?)->())
    func getAllTransactions(on completion: @escaping(DashboardSceneDataModel.TransactionResponse?,ApiError?)->())
    func fundTransfer(params:[String:Any], on completion:@escaping(TransferSceneDataModel.TransferResponse?,ApiError?)->())
}

extension ServiceProtocol {
    func registerUser(request:RegisterScene.Request, on completion:@escaping(RegisterScene.Response?,ApiError?)->()){}
    func startLogin(request:LoginSceneDataModel.Request, on completion:@escaping(LoginSceneDataModel.Response?,ApiError?)->()){}
    func checkBalances(on completion: @escaping(DashboardSceneDataModel.BalanceResponse?,ApiError?)->()){}
    func getAllPayee(on completion: @escaping(TransferSceneDataModel.PayeeResponse?,ApiError?)->()){}
    func getAllTransactions(on completion: @escaping(DashboardSceneDataModel.TransactionResponse?,ApiError?)->()){}
    func fundTransfer(params:[String:Any], on completion:@escaping(TransferSceneDataModel.TransferResponse?,ApiError?)->()){}
}

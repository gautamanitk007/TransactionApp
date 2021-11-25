//
//  APIProtocol.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation

public protocol ServiceProtocol {
    func startLogin(request:LoginSceneDataModel.Request, on completion:@escaping(LoginSceneDataModel.Response?,ApiError?)->())
    func checkBalances(on completion: @escaping(BalanceResponse?,ApiError?)->())
    func getAllPayee(on completion: @escaping(PayeeResponse?,ApiError?)->())
    func getAllTransactions(on completion: @escaping(TransactionResponse?,ApiError?)->())
    func fundTransfer(params:[String:Any], on completion:@escaping(TransferResponse?,ApiError?)->())
}

extension ServiceProtocol {
    func startLogin(request:LoginSceneDataModel.Request, on completion:@escaping(LoginSceneDataModel.Response?,ApiError?)->()){}
    func checkBalances(on completion: @escaping(BalanceResponse?,ApiError?)->()){}
    func getAllPayee(on completion: @escaping(PayeeResponse?,ApiError?)->()){}
    func getAllTransactions(on completion: @escaping(TransactionResponse?,ApiError?)->()){}
    func fundTransfer(params:[String:Any], on completion:@escaping(TransferResponse?,ApiError?)->()){}
}

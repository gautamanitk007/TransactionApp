//
//  APIProtocol.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation

public protocol ServiceProtocol {
    func startLogin(user userModel:UserModel, on completion: @escaping(_ response: ResponseCase<LoginResponse>) -> Void)
    func checkBalances(on completion: @escaping(_ response: ResponseCase<BalanceResponse>) -> Void )
    func getAllPayee(on completion: @escaping(_ response: ResponseCase<PayeeResponse>) -> Void)
    func getAllTransactions(on completion: @escaping(_ response: ResponseCase<TransactionResponse>) -> Void)
    func fundTransfer(params:[String:Any], on completion:@escaping(_ response: ResponseCase<TransactionResponse>) -> Void)
}

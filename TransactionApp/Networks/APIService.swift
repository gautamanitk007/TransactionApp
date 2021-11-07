//
//  APIService.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation

public class APIService: ServiceProtocol {
    var apiManager: APIManagerProtocol
    var endPoint: EndPoints
    init(_ apiManager:APIManagerProtocol, _ endPoint: EndPoints) {
        self.apiManager = apiManager
        self.endPoint = endPoint
    }
    public func startLogin(user userModel:UserModel, on completion: @escaping(_ response: ResponseCase<LoginResponse>) -> Void) {
        let body = userModel.jsonValue()
        let request = APIRequest(endPoint: self.endPoint.rawValue, postBody: body!)
        self.apiManager.runAPI(request) { (responseCase) in
            completion(responseCase)
        }
    }
    
    public func checkBalances(on completion: @escaping (ResponseCase<BalanceResponse>) -> Void) {
        
    }
    
    public func getAllPayee(on completion: @escaping (ResponseCase<PayeeResponse>) -> Void) {
        
    }
    
    public func getAllTransactions(on completion: @escaping (ResponseCase<TransactionResponse>) -> Void) {
        
    }
    
    public func fundTransfer(params: [String : Any], on completion: @escaping (ResponseCase<TransactionResponse>) -> Void) {
        
    }
}


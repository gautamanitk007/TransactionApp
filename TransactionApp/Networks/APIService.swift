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
    public func startLogin(user userModel:UserModel, on completion:@escaping(LoginResponse?,ApiError?)->()){
        if TransactionManager.shared.enableMock {
            guard let rsp: LoginResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "LoginResponse") else {
                completion(nil,nil)
                return
            }
            completion(rsp,nil)
        } else {
            let body = userModel.jsonValue()
            let request = APIRequest(endPoint: self.endPoint.rawValue, postBody: body!)
            let loginResource = Resource<LoginResponse>(request: request) { data in
                let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data)
                return loginResponse
            }
            self.apiManager.runAPI(resource: loginResource) { (response, error) in
                completion(response,error)
            }
        }
    }
    public func checkBalances(on completion: @escaping(BalanceResponse?,ApiError?)->()){
        if TransactionManager.shared.enableMock {
            guard let rsp: BalanceResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "Balance") else {
                completion(nil,nil)
                return
            }
            completion(rsp,nil)
        } else {
            var request = APIRequest(endPoint: self.endPoint.rawValue, postBody: [:])
            request.httpMethod = HttpMethod.get
            let balanceResource = Resource<BalanceResponse>(request: request) { data in
                let bResponse = try? JSONDecoder().decode(BalanceResponse.self, from: data)
                return bResponse
            }
            self.apiManager.runAPI(resource: balanceResource) { (response, error) in
                completion(response,error)
            }
        }
        
    }
    public func getAllPayee(on completion: @escaping(PayeeResponse?,ApiError?)->()){
        if TransactionManager.shared.enableMock {
            guard let rsp: PayeeResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "payee") else {
                completion(nil,nil)
                return
            }
            completion(rsp,nil)
        }else{
            var request = APIRequest(endPoint: self.endPoint.rawValue, postBody: [:])
            request.httpMethod = HttpMethod.get
            let payeeResource = Resource<PayeeResponse>(request: request) { data in
                let payeeResponse = try? JSONDecoder().decode(PayeeResponse.self, from: data)
                return payeeResponse
            }
            self.apiManager.runAPI(resource: payeeResource) { (response, error) in
                completion(response,error)
            }
        }
    }
    public func getAllTransactions(on completion: @escaping(TransactionResponse?,ApiError?)->()){
        
        if TransactionManager.shared.enableMock {
            guard let rsp: TransactionResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "Transactions") else {
                completion(nil,nil)
                return
            }
            completion(rsp,nil)
        } else {
            var request = APIRequest(endPoint: self.endPoint.rawValue, postBody: [:])
            request.httpMethod = HttpMethod.get
            let transationResource = Resource<TransactionResponse>(request: request) { data in
                let tResponse = try? JSONDecoder().decode(TransactionResponse.self, from: data)
                return tResponse
            }
            self.apiManager.runAPI(resource: transationResource) { (response, error) in
                completion(response,error)
            }
        }
       
    }
    public func fundTransfer(params:[String:Any], on completion:@escaping(TransferResponse?,ApiError?)->()){
        if TransactionManager.shared.enableMock {
            guard let rsp: TransferResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "Transfer") else {
                completion(nil,nil)
                return
            }
            completion(rsp,nil)
        }else{
            var request = APIRequest(endPoint: self.endPoint.rawValue, postBody: [:])
            request.httpMethod = HttpMethod.post
            request.body = params
            let tResource = Resource<TransferResponse>(request: request) { data in
                let tResponse = try? JSONDecoder().decode(TransferResponse.self, from: data)
                return tResponse
            }
            self.apiManager.runAPI(resource: tResource) { (response, error) in
                completion(response,error)
            }
        }
    }
}


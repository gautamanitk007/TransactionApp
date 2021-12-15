//
//  APIService.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation

public class APIService: ServiceProtocol {
    var apiManager: APIManagerProtocol
    init(_ apiManager:APIManagerProtocol) {
        self.apiManager = apiManager
    }
    public func registerUser(request:RegisterScene.Request, on completion:@escaping(RegisterScene.Response?,ApiError?)->()){
        if TransactionManager.shared.enableMock {
            DispatchQueue.main.async {
                guard let rsp: RegisterScene.Response = Utils.load(bundle: Bundle(for: APIService.self), fileName: "RegisterResponse") else {
                    completion(nil,ApiError(statusCode: -2, message: "Register mock parsing error"))
                    return
                }
                completion(rsp,nil)
            }
        } else {
            if let body = request.jsonValue(){
                let request = APIRequest(endPoint: EndPoints.register.rawValue, postBody: body)
                let regResource = Resource<RegisterScene.Response>(request: request) { data in
                    let registerResponse = try? JSONDecoder().decode(RegisterScene.Response.self, from: data)
                    return registerResponse
                }
                self.apiManager.runAPI(resource: regResource) { (response, error) in
                    completion(response,error)
                }
            }
        }
    }
    public func startLogin(request:LoginSceneDataModel.Request, on completion:@escaping(LoginSceneDataModel.Response?,ApiError?)->()){
        
        if TransactionManager.shared.enableMock {
            DispatchQueue.main.async {
                guard let rsp: LoginSceneDataModel.Response = Utils.load(bundle: Bundle(for: APIService.self), fileName: "LoginResponse") else {
                    completion(nil,ApiError(statusCode: -2, message: "Login mock parsing error"))
                    return
                }
                completion(rsp,nil)
            }
        } else {
            let body = request.jsonValue()
            let request = APIRequest(endPoint: EndPoints.login.rawValue, postBody: body!)
            let loginResource = Resource<LoginSceneDataModel.Response>(request: request) { data in
                let loginResponse = try? JSONDecoder().decode(LoginSceneDataModel.Response.self, from: data)
                return loginResponse
            }
            self.apiManager.runAPI(resource: loginResource) { (response, error) in
                completion(response,error)
            }
        }
    }
    public func checkBalances(on completion: @escaping(DashboardSceneDataModel.BalanceResponse?,ApiError?)->()){
        if TransactionManager.shared.enableMock {
            DispatchQueue.main.async {
                guard let rsp: DashboardSceneDataModel.BalanceResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "Balance") else {
                    completion(nil,ApiError(statusCode: -2, message: "Balance check parsing error"))
                    return
                }
                completion(rsp,nil)
            }
        } else {
            var request = APIRequest(endPoint: EndPoints.balances.rawValue, postBody: [:])
            request.httpMethod = HttpMethod.get
            let balanceResource = Resource<DashboardSceneDataModel.BalanceResponse>(request: request) { data in
                let bResponse = try? JSONDecoder().decode(DashboardSceneDataModel.BalanceResponse.self, from: data)
                return bResponse
            }
            self.apiManager.runAPI(resource: balanceResource) { (response, error) in
                completion(response,error)
            }
        }
        
    }
    public func getAllPayee(on completion: @escaping(TransferSceneDataModel.PayeeResponse?,ApiError?)->()){
        if TransactionManager.shared.enableMock {
            DispatchQueue.main.async {
                guard let rsp: TransferSceneDataModel.PayeeResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "Payee") else {
                    completion(nil,ApiError(statusCode: -2, message: "Payee parsing error"))
                    return
                }
                completion(rsp,nil)
            }
        }else{
            var request = APIRequest(endPoint: EndPoints.payees.rawValue, postBody: [:])
            request.httpMethod = HttpMethod.get
            let payeeResource = Resource<TransferSceneDataModel.PayeeResponse>(request: request) { data in
                let payeeResponse = try? JSONDecoder().decode(TransferSceneDataModel.PayeeResponse.self, from: data)
                return payeeResponse
            }
            self.apiManager.runAPI(resource: payeeResource) { (response, error) in
                completion(response,error)
            }
        }
    }
    public func getAllTransactions(on completion: @escaping(DashboardSceneDataModel.TransactionResponse?,ApiError?)->()){
        
        if TransactionManager.shared.enableMock {
            DispatchQueue.main.async {
                guard let rsp: DashboardSceneDataModel.TransactionResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "Transactions") else {
                    completion(nil,ApiError(statusCode: -2, message: "Transaction parsing error"))
                    return
                }
                completion(rsp,nil)
            }
        } else {
            var request = APIRequest(endPoint: EndPoints.transactions.rawValue, postBody: [:])
            request.httpMethod = HttpMethod.get
            let transationResource = Resource<DashboardSceneDataModel.TransactionResponse>(request: request) { data in
                let tResponse = try? JSONDecoder().decode(DashboardSceneDataModel.TransactionResponse.self, from: data)
                return tResponse
            }
            self.apiManager.runAPI(resource: transationResource) { (response, error) in
                completion(response,error)
            }
        }
       
    }
    public func fundTransfer(params:[String:Any], on completion:@escaping(TransferSceneDataModel.TransferResponse?,ApiError?)->()){
        if TransactionManager.shared.enableMock {
            DispatchQueue.main.async {
                guard let rsp: TransferSceneDataModel.TransferResponse = Utils.load(bundle: Bundle(for: APIService.self), fileName: "Transfer") else {
                    completion(nil,ApiError(statusCode: -2, message: "Transfer parsing error"))
                    return
                }
                completion(rsp,nil)
            }
        }else{
            var request = APIRequest(endPoint: EndPoints.transfer.rawValue, postBody: [:])
            request.httpMethod = HttpMethod.post
            request.body = params
            let tResource = Resource<TransferSceneDataModel.TransferResponse>(request: request) { data in
                let tResponse = try? JSONDecoder().decode(TransferSceneDataModel.TransferResponse.self, from: data)
                return tResponse
            }
            self.apiManager.runAPI(resource: tResource) { (response, error) in
                completion(response,error)
            }
        }
    }
}


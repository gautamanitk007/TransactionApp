//
//  APIRequest.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation

public enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}
public enum ResponseCodes: Int {
    case success = 200
    case badrequest = 400
    case token_invalid = 401
    case login_auth_failed = 403
    case network_timeout = -1001
    case server_notReachable = -1003
    case server_Not_Available = -1009
    case server_down = 503
}
public enum ContentType: String {
    case json = "application/json"
}

public enum Accept: String {
    case accept = "application/json"
}
enum EndPoints:String {
    case login = "/authenticate/login"
    case balances = "/account/balances"
    case payees = "/account/payees"
    case transactions = "/account/transactions"
    case transfer = "/transfer"
}
public struct ApiError{
    let statusCode:Int
    let message:String?
}
public struct Resource<T>{
    let request: APIRequest
    let parse:(Data) -> T?
}
public struct APIRequest {
    var endPoint: String
    var body: [String : Any]
    var httpMethod: HttpMethod = .post
    var contentType: ContentType = .json
    var accept: Accept = .accept
    var timeout: Double = 60.0

    var urlString: String {
        return TransactionManager.shared.baseURL + endPoint
    }
    
    var httpRequest: URLRequest? {
        guard let url = URL(string: self.urlString) else { return nil}
        var request: URLRequest  = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        request.timeoutInterval = self.timeout
        
        if TransactionManager.shared.token.count > 1 {
            request.setValue(TransactionManager.shared.token , forHTTPHeaderField: "Authorization")
        }
        request.setValue(self.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        request.setValue(self.accept.rawValue, forHTTPHeaderField: "Accept")
        
        if self.body.count > 0 {
            request.httpBody = try? JSONSerialization.data(withJSONObject: self.body)
        }
        return request
    }
    
    init(endPoint: String = "", postBody: [String:Any]) {
        self.endPoint = endPoint
        self.body = postBody
    }
}

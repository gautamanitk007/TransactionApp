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
    case server_down = 503
}
public enum ContentType: String {
    case json = "application/json"
}

public enum Accept: String {
    case accept = "application/json"
}

public enum Server:String{
    case baseURL = "http://127.0.0.1:8080/"
}

enum EndPoints:String {
    case login = "authenticate/login"
    case balances = "account/balances"
    case payees = "account/payees"
    case transactions = "account/transactions"
    case transfer = "transfer"
}
public enum ResponseCase<R> {
    case Success(R)
    case Failure(ResponseError, R?)
}
public struct ResponseError: Error {
    var code: String?
    var description: String?
    var localizedDescription: String?
  
    init(code: String? = nil, description:String? = nil, localizedDescription: String? = nil) {
        self.code = code
        self.description = description
        self.localizedDescription = localizedDescription
    }
}
public struct APIRequest {
    var endPoint: String
    var body: [String : Any]
    var baseURL:String? = Server.baseURL.rawValue
    var httpMethod: HttpMethod = .post
    var contentType: ContentType = .json
    var accept: Accept = .accept
    var timeout: Double = 60.0
    var headers: [String:String]?
    
    var urlString: String {
        return baseURL! + endPoint
    }
    
    var httpRequest: URLRequest? {
        guard let url = URL(string: self.urlString) else { return nil}
        var request: URLRequest  = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        request.timeoutInterval = self.timeout
        
        if let headerValues = self.headers {
            for header in headerValues {
                request.setValue(header.value , forHTTPHeaderField: header.key)
            }
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

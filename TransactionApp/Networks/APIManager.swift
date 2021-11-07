//
//  APIManager.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation

public typealias RequestCompletionHandler<R:Decodable> = (ResponseCase<R>) -> Void

protocol APIManagerProtocol {
    func runAPI<R: Decodable>(_ request: APIRequest, completionHandler:@escaping RequestCompletionHandler<R>)
}

public class APIManager: APIManagerProtocol {
    func runAPI<R: Decodable>(_ request: APIRequest, completionHandler:@escaping RequestCompletionHandler<R>) {
        
        guard let urlRequest = request.httpRequest else {
            let error:ResponseError = ResponseError(code: "400", description: "Bad URL", localizedDescription: "")
            let responseError: ResponseCase<R> = ResponseCase.Failure(error, nil)
            completionHandler(responseError)
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            var genericError: ResponseError = self.genericError()
            var responseCase: ResponseCase<R> = ResponseCase.Failure(genericError, nil)
            if let errorObj = error {
                genericError = self.errorValue(errorObj as NSError)
                responseCase = .Failure(genericError, nil)
            } else if let rawData = data  {
                if let json = try? JSONSerialization.jsonObject(with: rawData, options: .allowFragments) {
                    let responseObj = try? self.decodeObject(data: json as! [AnyHashable : Any], type: LoginResponse.self)
                    if responseObj?.status == "failed" {
                        genericError.description = Utils.getErrorMessage(for: response as! HTTPURLResponse)
                        responseCase = .Failure(genericError, nil)
                    }else{
                        responseCase = .Success(responseObj as! R)
                    }
                }
            }
            completionHandler(responseCase)
        }.resume()
    }
}

extension APIManager {
    func errorValue(_ error:NSError) -> ResponseError {
        var genericError: ResponseError = self.genericError()
        let userInfo = error.userInfo
        
        if let errorMsg = userInfo["responseDescription"] as? String {
            genericError.description = errorMsg
        } else {
            genericError.code = "\(error.code)"
            genericError.localizedDescription = error.localizedDescription
        }
        return genericError
    }
    func genericError() -> ResponseError {
        return ResponseError(code: "0", description: "Unknown Error", localizedDescription: "")
    }
    
    func decodeObject<R>(data: [AnyHashable: Any], type: R.Type) throws -> R? where R: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        return try JSONDecoder().decode(R.self, from:jsonData)
    }
}

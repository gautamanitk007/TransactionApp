//
//  APIManager.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation

protocol APIManagerProtocol {
    func runAPI<T>(resource:Resource<T>,completion:@escaping(T?,ApiError?)->())
}

public class APIManager: APIManagerProtocol {
    
    func runAPI<T>(resource:Resource<T>,completion:@escaping(T?,ApiError?)->()){
        if TransactionManager.shared.isNetworkAvailable {
            guard let urlRequest = resource.request.httpRequest else {
                DispatchQueue.main.async {
                    completion(nil,ApiError(statusCode: ResponseCodes.badrequest.rawValue, message: "Bad request"))
                }
                return
            }
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                var sError : ApiError?
                if let resp = response as? HTTPURLResponse{
                    sError = ApiError(statusCode: resp.statusCode, message: HTTPURLResponse.localizedString(forStatusCode: resp.statusCode))
                }
                DispatchQueue.main.async {
                    if let data = data {
                        let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
                        print(jsonResponse)
                        if sError?.statusCode == ResponseCodes.forbidden.rawValue{
                            let err = ApiError(statusCode: ResponseCodes.forbidden.rawValue, message: Utils.getLocalisedValue(key: "Already_Exist"))
                            completion(nil,err)
                        } else {
                            completion(resource.parse(data),sError)
                        }
                    }else{
                        if let err = sError {
                            completion(nil,err)
                        }else{
                            completion(nil,ApiError(statusCode: -1009, message: error?.localizedDescription))
                        }
                    }
                }
                
            }.resume()
        } else{
            DispatchQueue.main.async {
                completion(nil,ApiError(statusCode: ResponseCodes.server_notReachable.rawValue, message: "Server is not reachable"))
            }
        }
    }
}

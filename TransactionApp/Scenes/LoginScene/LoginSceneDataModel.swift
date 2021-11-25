//
//  LoginSceneDataModel.swift
//  TransactionApp
//
//  Created by Gautam Singh on 25/11/21.
//

import Foundation

public enum LoginSceneDataModel {
    public struct Request: Encodable {
        var username: String?
        var password: String?
        
        enum CodingKeys: String, CodingKey {
            case username
            case password
        }
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(username, forKey: .username)
            try container.encodeIfPresent(password, forKey: .password)
        }
    }
    public struct Response: Decodable {
        let status: String?
        let token: String?
        
        enum CodingKeys: String, CodingKey {
            case status
            case token
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            status =  try values.decodeIfPresent(String.self, forKey: .status)
            token = try values.decodeIfPresent(String.self, forKey: .token)
        }
    }
    public struct ViewModel {
        var message: String?
        var token: String?
        var error: String?
    }
    
    public struct Error{
        let error: String
    }
}

extension LoginSceneDataModel.Request {
     func jsonValue() -> [String:AnyObject]?{
         let jsonEncoder = JSONEncoder()
         if let jsonData = try? jsonEncoder.encode(self){
             return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:AnyObject]
         }
         return nil
     }
 }

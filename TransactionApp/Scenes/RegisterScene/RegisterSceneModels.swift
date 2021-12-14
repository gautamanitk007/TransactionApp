//
//  RegisterSceneModels.swift
//  TransactionApp
//
//  Created by Gautam Singh on 14/12/21.

import UIKit

public enum RegisterScene
{
    public struct Request: Encodable {
        var username: String?
        var password: String?
        var confirmPassword:String?
        enum CodingKeys: String, CodingKey {
            case username
            case password
            case confirmPassword
        }
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(username, forKey: .username)
            try container.encodeIfPresent(password, forKey: .password)
            try container.encodeIfPresent(password, forKey: .confirmPassword)
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
    public struct RegisterViewModel {
        var token: String
    }
    
    public struct ErrorViewModel{
        let error: String
    }
}

extension RegisterScene.Request {
     func jsonValue() -> [String:AnyObject]?{
         let jsonEncoder = JSONEncoder()
         if let jsonData = try? jsonEncoder.encode(self){
             return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:AnyObject]
         }
         return nil
     }
 }

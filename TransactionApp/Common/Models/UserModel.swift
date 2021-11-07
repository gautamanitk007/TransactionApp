//
//  UserModel.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation


public struct UserModel: Encodable {
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

extension UserModel {
    func jsonValue() -> [String:AnyObject]?{
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(self){
            return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:AnyObject]
        }
        return nil
    }
}

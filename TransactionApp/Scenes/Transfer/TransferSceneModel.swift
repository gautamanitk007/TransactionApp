//
//  TransferSceneModel.swift
//  TransactionApp
//
//  Created by Gautam Singh on 10/11/21.
//

import Foundation

struct TransferSceneModel:Encodable {
    var recipientAccountNo: String?
    var amount: String?
    var date:String?
    var description:String?
}

extension TransferSceneModel{
    func jsonValue() -> [String:AnyObject]?{
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(self){
            return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:AnyObject]
        }
        return nil
    }
}

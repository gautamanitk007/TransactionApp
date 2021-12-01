//
//  TransferSceneModel.swift
//  TransactionApp
//
//  Created by Gautam Singh on 10/11/21.
//

import Foundation

public enum TransferSceneDataModel{
    public struct PayeeResponse: Decodable {
        let status: String?
        let data: [Payee]?
        
        enum CodingKeys: String, CodingKey {
            case status
            case data
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            status =  try values.decodeIfPresent(String.self, forKey: .status)
            data = try values.decodeIfPresent(Array.self, forKey: .data)
        }
    }

    public struct TransferResponse: Decodable {
        let status: String?
        let data: Transfer?
        
        enum CodingKeys: String, CodingKey {
            case status
            case data
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            status =  try values.decodeIfPresent(String.self, forKey: .status)
            data = try values.decodeIfPresent(Transfer.self, forKey: .data)
        }
    }

    public struct Transfer:Decodable{
        let id: String?
        let recipientAccountNo: String?
        let amount: String?
        let date: String?
        let description: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case recipientAccountNo
            case amount
            case date
            case description
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id =  try values.decodeIfPresent(String.self, forKey: .id)
            recipientAccountNo = try values.decodeIfPresent(String.self, forKey: .recipientAccountNo)
            amount = try values.decodeIfPresent(String.self, forKey: .amount)
            date = try values.decodeIfPresent(String.self, forKey: .date)
            description = try values.decodeIfPresent(String.self, forKey: .description)
        }
    }

    public struct Payee: Decodable {
        let id: String?
        let accountNo:String?
        let accountHolderName: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case accountNo
            case accountHolderName
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id =  try values.decodeIfPresent(String.self, forKey: .id)
            accountNo =  try values.decodeIfPresent(String.self, forKey: .accountNo)
            accountHolderName = try values.decodeIfPresent(String.self, forKey: .accountHolderName)
        }
    }
    public struct TransferSceneViewModel:Encodable {
        var recipientAccountNo: String?
        var amount: String?
        var date:String?
        var description:String?
    }
}

extension TransferSceneDataModel.TransferSceneViewModel{
    func jsonValue() -> [String:AnyObject]?{
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(self){
            return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:AnyObject]
        }
        return nil
    }
}

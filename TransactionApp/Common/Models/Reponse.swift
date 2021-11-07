//
//  Reponse.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import Foundation


public struct LoginResponse: Decodable {
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

public struct BalanceResponse: Decodable {
    let status: String?
    let balance: Int32?
    
    enum CodingKeys: String, CodingKey {
        case status
        case balance
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status =  try values.decodeIfPresent(String.self, forKey: .status)
        balance = try values.decodeIfPresent(Int32.self, forKey: .balance)
    }
}

public struct TransactionResponse: Decodable {
    let status: String?
    let data: [Account]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status =  try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([Account].self, forKey: .data)
    }
}

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
    let amount: Double?
    let date: Date?
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
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        date = try values.decodeIfPresent(Date.self, forKey: .date)
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

public struct Account: Decodable {
    let id: String?
    let type: String?
    let amount:Double?
    let currency: String?
    let from: User?
    let to: User?
    let description: String?
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case currency
        case from
        case description
        case date
        case to
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id =  try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        from = try values.decodeIfPresent(User.self, forKey: .from)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        to = try values.decodeIfPresent(User.self, forKey: .to)
    }
}

public struct User: Decodable {
    let accountNo:String?
    let accountHolderName: String?
    
    enum CodingKeys: String, CodingKey {
        case accountNo
        case accountHolderName
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountNo =  try values.decodeIfPresent(String.self, forKey: .accountNo)
        accountHolderName = try values.decodeIfPresent(String.self, forKey: .accountHolderName)
    }
}

//
//  DashboardSceneModel.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.



import Foundation


public enum DashboardSceneDataModel{
    
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

    
    public struct BalanceViewModel {
        let balance:String
    }
    public class TransactionViewModel{
        let account:Account
        let date: Date
        init(acc: Account, date:Date) {
            self.account = acc
            self.date = date
        }
        
        var dayMonth:String{
            return self.date.dayMonth
        }
        var payToFrom:String{
            var msg: String = ""
            if let from = self.account.from, let user = from.accountHolderName {
                msg = self.account.type!.capitalized + "d" + " from " + user
            } else if let to = self.account.to, let user = to.accountHolderName {
                msg = self.account.type!.capitalized + " to " + user
            }
            return msg
        }
        var amount:NSMutableAttributedString {
            var coloredAmount = NSMutableAttributedString()
            if let amt = self.account.amount {
                if amt < 0 {
                    coloredAmount = Utils.getColoredText(txt: "\(amt)", color: .black)
                } else{
                    coloredAmount = Utils.getColoredText(txt: "\(amt)", color: .green)
                }
            }
            return coloredAmount
        }
    }

}

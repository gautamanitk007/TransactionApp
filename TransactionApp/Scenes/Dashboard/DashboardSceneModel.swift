//
//  DashboardSceneModel.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.



import Foundation

struct BalanceViewModel {
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

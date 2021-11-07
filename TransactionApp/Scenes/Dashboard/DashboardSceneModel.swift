//
//  DashboardSceneModel.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.



import Foundation

enum DashboardSceneModel {

    struct BalanceViewModel {
        var balance:String
    }
    
    struct TransactionList {
        var tansactions: [Transaction]
    }
    
    struct Transaction {
        var day: String
        var transferRecieve: String
        var amount: String
    }
}

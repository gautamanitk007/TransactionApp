//
//  TransactionManager.swift
//  TransactionApp
//
//  Created by Gautam Singh on 9/11/21.
//

import Foundation

class TransactionManager:NSObject {
    static let shared = TransactionManager()
    var token: String = ""
    var enableMock: Bool = false
    var baseURL: String = "http://127.0.0.1:8080"
    var totalBalance: Float = 0.0
}

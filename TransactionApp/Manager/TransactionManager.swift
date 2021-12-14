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
    var baseURL: String = "https://green-thumb-64168.uc.r.appspot.com/"
    var totalBalance: Float = 0.0
    var isNetworkAvailable:Bool = false
}

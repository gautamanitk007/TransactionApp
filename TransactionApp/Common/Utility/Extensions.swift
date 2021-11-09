//
//  Extensions.swift
//  TransactionApp
//
//  Created by Gautam Singh on 8/11/21.
//

import Foundation

extension Date{
    var dayMonth:String {
        let formatter = Utils.getFormator()
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: self)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: self)
        return "\(day) \(month)"
    }
}
extension String{
    var dateFromISO8601: Date? {
        let formatter = Utils.getFormator()
        return formatter.date(from: self)
    }
}



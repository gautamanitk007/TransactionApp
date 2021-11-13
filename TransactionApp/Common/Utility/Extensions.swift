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
    func convertToString()->String{
        let formatter = Utils.getFormator()
        formatter.dateFormat = "dd-MM-YYYY"
        return formatter.string(from: self)
    }
}
extension String{
    var dateFromISO8601: Date? {
        let formatter = Utils.getFormator()
        return formatter.date(from: self)
    }
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var intValue: Int {
        return (self as NSString).integerValue
    }
    
}



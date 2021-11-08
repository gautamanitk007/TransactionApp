//
//  Extensions.swift
//  TransactionApp
//
//  Created by Gautam Singh on 8/11/21.
//

import Foundation

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}


extension Date{
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    var dayMonth:String {
        Formatter.iso8601.dateFormat = "MMM"
        let month = Formatter.iso8601.string(from: self)
        Formatter.iso8601.dateFormat = "dd"
        let day = Formatter.iso8601.string(from: self)
        return "\(day) \(month)"
    }
}
extension String{
    var dateFromISO8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
}



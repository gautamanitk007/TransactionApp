//
//  Utils.swift
//  TransactionApp
//
//  Created by Gautam Singh on 7/11/21.
//

import UIKit
import Foundation

class Utils {
    class func getAlert(title:String,message:String) -> UIAlertController {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover
        alert.addAction(UIAlertAction(title:NSLocalizedString("Button_OK_Title",comment: ""), style: .default) { _ in})
        return alert
    }
    class func load<T:Decodable>(bundle:Bundle, fileName: String) -> T?{
        do{
            let data = try bundle.path(forResource: fileName, ofType: "json",inDirectory: nil).flatMap({ jPath in
                return try Data(contentsOf: URL(fileURLWithPath: jPath))
            })
            let response: T? = try data.flatMap({ jsonData in
                return try JSONDecoder().decode(T.self, from: jsonData)
            })
            return response
        }catch {
            print("Failed to load data")
        }
        return nil
    }
    class func getColoredText(txt: String,color:UIColor) -> NSMutableAttributedString{
        let range = (txt as NSString).range(of: txt)
        let colordValue = NSMutableAttributedString.init(string: txt)
        colordValue.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return colordValue
    }
    class func getFormator() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }
}

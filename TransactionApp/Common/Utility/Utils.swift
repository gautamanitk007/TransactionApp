//
//  Utils.swift
//  TransactionApp
//
//  Created by Gautam Singh on 7/11/21.
//

import UIKit
import Foundation
import SystemConfiguration
class Utils {
    class func getAlert(title:String,message:String) -> UIAlertController {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover
        alert.addAction(UIAlertAction(title:Utils.getLocalisedValue(key:"Button_OK_Title"), style: .default) { _ in})
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
    
    class func createButton(textField: UITextField,imgName:String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imgName), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        textField.rightView = button
        textField.rightViewMode = .always
        return button
    }
    class func getLocalisedValue(key:String) -> String{
        return NSLocalizedString(key,comment: "")
    }
}

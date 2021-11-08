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
    class func saveInDefaults(value str: String, forKey key: String){
        let appDefaults = UserDefaults.standard
        appDefaults.setValue(str, forKey: key)
        appDefaults.synchronize()
    }
    class func getValue(forKey key: String) -> String?{
        let appDefaults = UserDefaults.standard
        if let value = appDefaults.value(forKey: key) as? String, value.count > 1 {
            return value
        }else{
            return nil
        }
    }
    class func getColoredText(txt: String,color:UIColor) -> NSMutableAttributedString{
        let range = (txt as NSString).range(of: txt)
        let colordValue = NSMutableAttributedString.init(string: txt)
        colordValue.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return colordValue
    }
}

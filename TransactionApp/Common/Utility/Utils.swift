//
//  Utils.swift
//  TransactionApp
//
//  Created by Gautam Singh on 7/11/21.
//

import UIKit

class Utils {
    static func getAlert(title:String,message:String) -> UIAlertController {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.modalPresentationStyle = .popover
        alert.addAction(UIAlertAction(title:NSLocalizedString("Button_OK_Title",comment: ""), style: .default) { _ in})
        return alert
    }
    static func getErrorMessage(for response: HTTPURLResponse) -> String {
        var errorMessage: String = ""
        switch response.statusCode {
        case ResponseCodes.badrequest.rawValue:
                errorMessage = NSLocalizedString("Error_Badrequest",comment: "")
        case ResponseCodes.token_invalid.rawValue:
                errorMessage = NSLocalizedString("Error_Token",comment: "")
        case ResponseCodes.login_auth_failed.rawValue:
                errorMessage = NSLocalizedString("Error_Authentication",comment: "")
        case ResponseCodes.network_timeout.rawValue:
                errorMessage = NSLocalizedString("Error_timeout",comment: "")
        case ResponseCodes.server_notReachable.rawValue:
                errorMessage = NSLocalizedString("Error_Server_Unreachable",comment: "")
        case ResponseCodes.server_down.rawValue:
                errorMessage = NSLocalizedString("Error_Server_Down",comment: "")
        default:
            errorMessage = NSLocalizedString("Unknown",comment: "")
        }
        return errorMessage
    }
}

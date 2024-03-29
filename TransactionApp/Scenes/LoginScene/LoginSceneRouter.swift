//
//  LoginSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
import UIKit

protocol Failure {
    func showFailure(message: String)
}

final class LoginSceneRouter {
    weak var viewController: UIViewController?
}

extension LoginSceneRouter: LoginSceneRoutingLogic {
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        viewController?.present(alertController, animated: true)
    }
    
    func showDashboard() {
        let dashboardVC = Utils.getViewController(identifier: "showDashboard") as! DashboardSceneViewController
        viewController?.navigationController?.pushViewController(dashboardVC, animated: true)
    }
    func showRegister() {
        let registerVC = Utils.getViewController(identifier: "RegisterScene") as! RegisterSceneViewController
        viewController?.navigationController?.pushViewController(registerVC, animated: true)
    }
}

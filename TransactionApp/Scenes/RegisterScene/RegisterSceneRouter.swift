//
//  RegisterSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 14/12/21.


import UIKit



final class RegisterSceneRouter {
    
  weak var viewController: RegisterSceneViewController?
  
}

extension RegisterSceneRouter:RegisterSceneRoutingLogic{
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        viewController?.present(alertController, animated: true)
    }
    
    func showDashboard() {
        let dashboardVC = Utils.getViewController(identifier: "showDashboard") as! DashboardSceneViewController
        viewController?.navigationController?.pushViewController(dashboardVC, animated: true)
    }
}

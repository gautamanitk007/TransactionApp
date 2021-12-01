//
//  DashboardSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
import UIKit

protocol DashboardSceneRoutingLogic:Failure {
    func popToPrevious()
    func showNextController()
}

final class DashboardSceneRouter {
    weak var viewController: UIViewController?
}

extension DashboardSceneRouter: DashboardSceneRoutingLogic {
    func showNextController() {
        let transferVC = Utils.getViewController(identifier: "ShowTransfer") as! TransferSceneViewController
        self.viewController?.navigationController?.pushViewController(transferVC, animated: true)
    }
    
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        self.viewController?.present(alertController, animated: true)
    }
    func popToPrevious(){
        self.viewController?.navigationController?.popViewController(animated: true)
    }

}

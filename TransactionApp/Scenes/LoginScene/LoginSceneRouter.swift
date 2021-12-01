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

protocol LoginSceneRoutingLogic: Failure {
    func showDashboard()
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
        let sceneFactory = DefaultSceneFactory()
        sceneFactory.dashboardConfigurator = DefaultDashboardSceneConfigurator(sceneFactory: sceneFactory)
        let scene = sceneFactory.makeDashboardScene()
        viewController?.navigationController?.pushViewController(scene, animated: true)
    }
}

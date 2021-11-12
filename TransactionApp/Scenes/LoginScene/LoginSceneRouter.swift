//
//  LoginSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
import UIKit

protocol TError {
    func showFailure(message: String)
}

protocol LoginSceneRouting:TError {
    func showLoginSuccess()
}

final class LoginSceneRouter {
    weak var source: UIViewController?

    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension LoginSceneRouter: LoginSceneRouting {
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        source?.present(alertController, animated: true)
    }
    
    func showLoginSuccess() {
        let sceneFactory = DefaultSceneFactory()
        sceneFactory.dashboardConfigurator = DefaultDashboardSceneConfigurator(sceneFactory: sceneFactory)
        let scene = sceneFactory.makeDashboardScene()
        source?.navigationController?.pushViewController(scene, animated: true)
    }
}

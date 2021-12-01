//
//  DashboardSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
import UIKit

protocol DashboardSceneRouting:Failure {
    func popToPrevious()
    func showNextController()
}

final class DashboardSceneRouter {
    weak var source: UIViewController?

    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension DashboardSceneRouter: DashboardSceneRouting {
    func showNextController() {
        let sceneFactory = DefaultSceneFactory()
        sceneFactory.transferConfigurator = DefaultTransferSceneConfigurator(sceneFactory: sceneFactory)
        let scene = sceneFactory.makeTransferScene()
        source?.navigationController?.pushViewController(scene, animated: true)
    }
    
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        source?.present(alertController, animated: true)
    }
    func popToPrevious(){
        self.source?.navigationController?.popViewController(animated: true)
    }

}

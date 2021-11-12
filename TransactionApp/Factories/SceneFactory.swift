//
//  SceneFactory.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
import UIKit
protocol SceneFactory {
    var configurator: LoginSceneConfigurator! { get set }
    var dashboardConfigurator: DashboardSceneConfigurator!{get set}
    var transferConfigurator: TransferSceneConfigurator!{get set}
    func makeLoginScene() -> LoginSceneViewController
    func makeDashboardScene() -> DashboardSceneViewController
    func makeTransferScene() -> TransferSceneViewController
}

final class DefaultSceneFactory: SceneFactory {
    var transferConfigurator: TransferSceneConfigurator!
    var configurator: LoginSceneConfigurator!
    var dashboardConfigurator: DashboardSceneConfigurator!
    func makeLoginScene() -> LoginSceneViewController {
        let loginVC = self.getViewController(identifier: "LoginScene") as! LoginSceneViewController
        return configurator.configured(loginVC)
    }
    func makeDashboardScene() -> DashboardSceneViewController {
        let dashboardVC = self.getViewController(identifier: "showDashboard") as! DashboardSceneViewController
        return dashboardConfigurator.configured(dashboardVC)
    }
    func makeTransferScene() -> TransferSceneViewController{
        let transferVC = self.getViewController(identifier: "ShowTransfer") as! TransferSceneViewController
        return transferConfigurator.configured(transferVC)
    }
}

private extension DefaultSceneFactory{
    func getViewController(identifier:String) -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

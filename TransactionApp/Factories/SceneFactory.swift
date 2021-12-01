//
//  SceneFactory.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
import UIKit
protocol SceneFactory {
    var dashboardConfigurator: DashboardSceneConfigurator!{get set}
    var transferConfigurator: TransferSceneConfigurator!{get set}
    func makeDashboardScene() -> DashboardSceneViewController
    func makeTransferScene() -> TransferSceneViewController
}

final class DefaultSceneFactory: SceneFactory {
    var transferConfigurator: TransferSceneConfigurator!
    var dashboardConfigurator: DashboardSceneConfigurator!
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

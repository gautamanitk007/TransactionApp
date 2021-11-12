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
    var dashboardConfigurator : DashboardSceneConfigurator!{get set}
    func makeLoginScene() -> UIViewController
    func makeDashboardScene() -> UIViewController
    
}

final class DefaultSceneFactory: SceneFactory {
    var configurator: LoginSceneConfigurator!
    var dashboardConfigurator: DashboardSceneConfigurator!
    func makeLoginScene() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginScene") as! LoginSceneViewController
        return configurator.configured(loginVC)
    }
    func makeDashboardScene() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "showDashboard") as! DashboardSceneViewController
        return dashboardConfigurator.configured(dashboardVC)
    }
}

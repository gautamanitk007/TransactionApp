//
//  DashboardSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol DashboardSceneRouting {
  
  func routeTo(_ route: DashboardSceneModel.Route)
}

final class DashboardSceneRouter {
  
  private weak var viewController: UIViewController?
  
  init(viewController: UIViewController?) {
    self.viewController = viewController
  }
}


// MARK: - DashboardSceneRouting
extension DashboardSceneRouter: DashboardSceneRouting {
  
  func routeTo(_ route: DashboardSceneModel.Route) {
    DispatchQueue.main.async {
      switch route {
        
      case .dismissDashboardSceneScene:
        self.dismissDashboardSceneScene()
        
      case .xScene(let data):
        self.showXSceneBy(data)
      }
    }
  }
}


// MARK: - Private Zone
private extension DashboardSceneRouter {
  
  func dismissDashboardSceneScene() {
    viewController?.dismiss(animated: true)
  }
  
  func showXSceneBy(_ data: Int) {
    print("will show the next screen")
  }
}

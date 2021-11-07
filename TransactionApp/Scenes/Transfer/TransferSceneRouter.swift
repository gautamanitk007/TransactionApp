//
//  TransferSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol TransferSceneRouting {
  
  func routeTo(_ route: TransferSceneModel.Route)
}

final class TransferSceneRouter {
  
  private weak var viewController: UIViewController?
  
  init(viewController: UIViewController?) {
    self.viewController = viewController
  }
}


// MARK: - TransferSceneRouting
extension TransferSceneRouter: TransferSceneRouting {
  
  func routeTo(_ route: TransferSceneModel.Route) {
    DispatchQueue.main.async {
      switch route {
        
      case .dismissTransferSceneScene:
        self.dismissTransferSceneScene()
        
      case .xScene(let data):
        self.showXSceneBy(data)
      }
    }
  }
}


// MARK: - Private Zone
private extension TransferSceneRouter {
  
  func dismissTransferSceneScene() {
    viewController?.dismiss(animated: true)
  }
  
  func showXSceneBy(_ data: Int) {
    print("will show the next screen")
  }
}

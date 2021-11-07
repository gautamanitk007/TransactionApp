//
//  DashboardSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol DashboardSceneRouting {
    func navigateToDestination(for indetifier:String)
    func showAPIFailure(message: String)
    func popToPrevious()
}

final class DashboardSceneRouter {
    private weak var viewController: UIViewController?
  
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

// MARK: - DashboardSceneRouting
extension DashboardSceneRouter: DashboardSceneRouting {
    
    func navigateToDestination(for indetifier:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: indetifier) as? TransferSceneViewController else {
            fatalError("Destination doesn't exist")
        }
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func showAPIFailure(message: String) {
        let alertController = Utils.getAlert(title:NSLocalizedString("Information_Error_Title",comment: ""),message:message)
        self.viewController?.present(alertController, animated: true)
    }
    
    func popToPrevious() {
        Utils.saveInDefaults(value: "", forKey: "token")
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}


//
//  LoginSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol LoginSceneRouting {
    func navigateToDestination(for indetifier:String, token:String)
    func showLogingFailure(message: String)
}

final class LoginSceneRouter {
    private weak var viewController: UIViewController?
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}


// MARK: - LoginSceneRouting
extension LoginSceneRouter: LoginSceneRouting {
    func navigateToDestination(for indetifier:String, token:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: indetifier) as? DashboardSceneViewController else {
            fatalError("Destination doesn't exist")
        }
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func showLogingFailure(message: String) {
        let alertController = Utils.getAlert(title:NSLocalizedString("Information_Error_Title",comment: ""),message:message)
        self.viewController?.present(alertController, animated: true)
    }
}


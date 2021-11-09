//
//  TransactionSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 9/11/21.
//

import Foundation
import UIKit

protocol TransactionSceneRouting {
    func navigateToDestination(for indetifier:String)
    func showLogingFailure(message: String)
    func popToPrevious()
}

final class TransactionSceneRouter {
    private weak var viewController: UIViewController?
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}


// MARK: - LoginSceneRouting
extension TransactionSceneRouter: TransactionSceneRouting {
    func navigateToDestination(for indetifier:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: indetifier)
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func showLogingFailure(message: String) {
        let alertController = Utils.getAlert(title:NSLocalizedString("Information_Error_Title",comment: ""),message:message)
        self.viewController?.present(alertController, animated: true)
    }
    func popToPrevious() {
        TransactionManager.shared.token = ""
        self.viewController?.navigationController?.popViewController(animated: true)
    }

}


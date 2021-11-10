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
    func showFailure(message: String)
    func showSuccess(msg:String)
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
    func navigateToDestination(for indentifier:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: indentifier)
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        self.viewController?.present(alertController, animated: true)
    }
    func popToPrevious() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    func showSuccess(msg:String){
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Success_Title"),message:msg)
        self.viewController?.present(alertController, animated: true)
    }
    func showPopOver(for indetifier:String, popoverList:[Payee], delegate:DropdownViewControllerDelegate){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: indetifier) as! DropdownViewController
        destinationVC.payeeList = popoverList
        destinationVC.modalPresentationStyle = .popover
        destinationVC.delegate = delegate
        let popover: UIPopoverPresentationController = destinationVC.popoverPresentationController!
        self.viewController?.present(destinationVC, animated: true, completion: nil)
    }

}


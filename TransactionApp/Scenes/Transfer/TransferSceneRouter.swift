//
//  TransferSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
import UIKit

protocol TransferSceneRoutingLogic:Failure {
    func popToPrevious()
    func showSuccess(msg:String)
    func showPopOver(for indetifier:String, popoverList:[TransferSceneDataModel.Payee], delegate:DropdownViewControllerDelegate)
}

final class TransferSceneRouter {
    weak var viewController: UIViewController?

}

extension TransferSceneRouter: TransferSceneRoutingLogic {

    func showSuccess(msg:String){
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Success_Title"),message:msg)
        self.viewController?.present(alertController, animated: true)
    }
    
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        self.viewController?.present(alertController, animated: true)
    }
    func popToPrevious(){
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showPopOver(for indetifier:String, popoverList:[TransferSceneDataModel.Payee], delegate:DropdownViewControllerDelegate){
        let destinationVC = Utils.getViewController(identifier: "showPopover") as! DropdownViewController
        destinationVC.payeeList = popoverList
        destinationVC.delegate = delegate
        destinationVC.modalPresentationStyle = .popover
        self.viewController!.present(destinationVC, animated: true, completion: nil)
    }

}

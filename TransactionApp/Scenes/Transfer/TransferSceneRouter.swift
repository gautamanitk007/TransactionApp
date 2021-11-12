//
//  TransferSceneRouter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//

import Foundation
import UIKit

protocol TransferSceneRouting:TError {
    func popToPrevious()
    func showSuccess(msg:String)
    func showPopOver(for indetifier:String, popoverList:[Payee], delegate:DropdownViewControllerDelegate)
}

final class TransferSceneRouter {
    weak var source: UIViewController?

    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension TransferSceneRouter: TransferSceneRouting {

    func showSuccess(msg:String){
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Success_Title"),message:msg)
        self.source?.present(alertController, animated: true)
    }
    
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        source?.present(alertController, animated: true)
    }
    func popToPrevious(){
        self.source?.navigationController?.popViewController(animated: true)
    }
    
    func showPopOver(for indetifier:String, popoverList:[Payee], delegate:DropdownViewControllerDelegate){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "showPopover") as! DropdownViewController
        destinationVC.payeeList = popoverList
        destinationVC.delegate = delegate
        destinationVC.modalPresentationStyle = .popover
        self.source!.present(destinationVC, animated: true, completion: nil)
    }

}

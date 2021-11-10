//
//  TransferScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol TransferScenePresentationLogic {
    func showPayeeList(response: PayeeResponse)
    func showErrorMessage( error: String?)
    func transferSuccess(response:TransferResponse)
}

final class TransferScenePresenter {
    private weak var viewController: TransferSceneDisplayLogic?
  
    init(viewController: TransferSceneDisplayLogic?) {
        self.viewController = viewController
    }
}


// MARK: - TransferScenePresentationLogic
extension TransferScenePresenter: TransferScenePresentationLogic {
   
    
    func showPayeeList(response: PayeeResponse) {
        if let payeeList = response.data, payeeList.count > 0{
            let sortedPayeeList = payeeList.sorted { (payee1, payee2) -> Bool in
                return payee1.accountHolderName! < payee2.accountHolderName!
            }
            self.viewController?.dispayPayee(payeeList: sortedPayeeList)
        } else {
            self.viewController?.displayError(Utils.getLocalisedValue(key:"Payee_Not_Exist"))
        }
    }
    func showErrorMessage(error: String?) {
        self.viewController?.displayError(error ?? Utils.getLocalisedValue(key:"Unkown"))
    }
    func transferSuccess(response: TransferResponse) {
        let amount = response.data?.amount?.floatValue ?? 0.0
        TransactionManager.shared.totalBalance -= amount
        self.viewController?.transferSuccess(msg: Utils.getLocalisedValue(key: "Payment_Success"))
    }
}



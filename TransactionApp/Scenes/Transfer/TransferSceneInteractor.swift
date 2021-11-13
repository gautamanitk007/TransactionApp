//
//  TransferSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

typealias TransferSceneInteractorInput = TransferSceneViewControllerOutput

protocol TransferSceneInteractorOutput {
    func showPayeeList(response: PayeeResponse)
    func showErrorMessage( error: String?)
    func transferSuccess(response:TransferResponse)
}

final class TransferSceneInteractor {
    var presenter: TransferScenePresenterInput?
    var service: ServiceProtocol?
}


// MARK: - TransferSceneViewControllerOutput
extension TransferSceneInteractor: TransferSceneViewControllerOutput {
    func getAllPayee() {
        self.service?.getAllPayee { [weak self] (response,error) in
            guard let self = self else { return }
            if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue{
                self.presenter?.showErrorMessage(error: errorValue.message)
            } else if let payeeList = response {
                self.presenter?.showPayeeList(response: payeeList)
            }
        }
    }
    func transferTo(payee:TransferSceneModel){
        
        if payee.recipientAccountNo == nil || payee.recipientAccountNo?.count == 0  {
            self.presenter?.showErrorMessage(error: Utils.getLocalisedValue(key:"Recipient_Key"))
            return
        }
    
        if payee.description == nil || payee.description?.count == 0 {
            self.presenter?.showErrorMessage(error:Utils.getLocalisedValue(key:"Description_Key"))
            return
        }
        
        if payee.date == nil {
            self.presenter?.showErrorMessage(error:Utils.getLocalisedValue(key:"Date_Key"))
            return
        }
        
        if payee.amount == nil || payee.amount?.count == 0 {
            self.presenter?.showErrorMessage(error:Utils.getLocalisedValue(key:"Amount_Key"))
            return
        }
        if payee.amount!.floatValue > TransactionManager.shared.totalBalance  {
            self.presenter?.showErrorMessage(error: Utils.getLocalisedValue(key: "Amount_Overflow"))
            return
        }
        if let json = payee.jsonValue(){
            DispatchQueue.global(qos: .userInitiated).async {
                self.service?.fundTransfer(params: json) {[weak self] (response, error) in
                    guard let self = self else { return }
                    if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue {
                        self.presenter?.showErrorMessage(error: errorValue.message)
                    } else if let tResponse = response {
                        self.presenter?.transferSuccess(response: tResponse)
                    }
                }
            }
        } else {
            self.presenter?.showErrorMessage(error: Utils.getLocalisedValue(key: "Unkown"))
        }
        
    }
}

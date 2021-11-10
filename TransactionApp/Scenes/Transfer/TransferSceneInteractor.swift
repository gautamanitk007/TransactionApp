//
//  TransferSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

typealias TransferSceneInteractable = TransferSceneBusinessLogic

protocol TransferSceneBusinessLogic {
    func getAllPayee(service: ServiceProtocol)
    func transferTo(payee:TransferSceneModel,service:ServiceProtocol)
}

final class TransferSceneInteractor {
    private var presenter: TransferScenePresentationLogic
    init(viewController: TransferSceneDisplayLogic?) {
        self.presenter = TransferScenePresenter(viewController: viewController)
    }
}


// MARK: - TransferSceneBusinessLogic
extension TransferSceneInteractor: TransferSceneBusinessLogic {
    func getAllPayee(service: ServiceProtocol) {
        DispatchQueue.global(qos: .userInitiated).async {
            service.getAllPayee { [weak self] (response,error) in
                guard let self = self else { return }
                if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue{
                    self.presenter.showErrorMessage(error: errorValue.message)
                } else if let payeeList = response {
                    self.presenter.showPayeeList(response: payeeList)
                }
            }
        }
    }
    func transferTo(payee:TransferSceneModel,service:ServiceProtocol){
        if payee.recipientAccountNo == nil  {
            self.presenter.showErrorMessage(error: Utils.getLocalisedValue(key:"Recipient_Key"))
            return
        }
        if payee.description == nil || payee.description?.count == 0 {
            self.presenter.showErrorMessage(error:Utils.getLocalisedValue(key:"Description_Key"))
            return
        }
        
        if payee.amount == nil || payee.amount?.count == 0 {
            self.presenter.showErrorMessage(error:Utils.getLocalisedValue(key:"Amount_Key"))
            return
        }
        if Float(payee.amount!)! > Float(payee.payorBalance!)!   {
            self.presenter.showErrorMessage(error: Utils.getLocalisedValue(key: "Amount_Overflow"))
            return
        }
    

    }
}

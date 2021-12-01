//
//  TransferSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

final class TransferSceneInteractor {
    var presenter: TransferScenePresentationLogic?
    var service: ServiceProtocol = APIService(APIManager())
}


// MARK: - TransferSceneBusinessLogic
extension TransferSceneInteractor: TransferSceneBusinessLogic {
    func getAllPayee() {
        self.service.getAllPayee { [weak self] (response,error) in
            guard let self = self else { return }
            if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue{
                self.presenter?.showErrorMessage(error: errorValue.message)
            } else if let payeeList = response {
                self.presenter?.showPayeeList(response: payeeList)
            }
        }
    }
    func transferTo(payee:TransferSceneDataModel.TransferSceneViewModel){
        
        if payee.recipientAccountNo == nil || payee.recipientAccountNo?.count == 0  {
            self.presenter?.showErrorMessage(error: Utils.getLocalisedValue(key:"Recipient_Key"))
            return
        }
    
        if payee.description == nil || payee.description?.count == 0 {
            self.presenter?.showErrorMessage(error:Utils.getLocalisedValue(key:"Description_Key"))
            return
        }
        
        if payee.date == nil || payee.date?.count == 0 {
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
            self.service.fundTransfer(params: json) {[weak self] (response, error) in
                guard let self = self else { return }
                if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue {
                    self.presenter?.showErrorMessage(error: errorValue.message)
                } else if let tResponse = response {
                    self.presenter?.transferSuccess(response: tResponse)
                }
            }
        } else {
            self.presenter?.showErrorMessage(error: Utils.getLocalisedValue(key: "Unkown"))
        }
        
    }
}

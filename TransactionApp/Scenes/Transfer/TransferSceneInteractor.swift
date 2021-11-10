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
    func transferTo(amount:Double,toPayee:Payee)
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
                    self.presenter.didFailedToLoad(error: errorValue.message)
                } else if let payeeList = response {
                    self.presenter.showPayeeList(response: payeeList)
                }
            }
        }
    }
    func transferTo(amount:Double,toPayee:Payee){
        
    }
}

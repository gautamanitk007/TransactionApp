//
//  DashboardSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

typealias DashboardSceneInteractable = DashboardSceneBusinessLogic

protocol DashboardSceneBusinessLogic {
    func checkBalance(service: ServiceProtocol)
    func getAllTransactions(service: ServiceProtocol)
}

final class DashboardSceneInteractor {
    
    private var presenter: DashboardScenePresentationLogic
    
    init(viewController: DashboardSceneDisplayLogic?) {
     
        self.presenter = DashboardScenePresenter(viewController: viewController)
    }
}


// MARK: - DashboardSceneBusinessLogic
extension DashboardSceneInteractor: DashboardSceneBusinessLogic {
    
    func checkBalance(service: ServiceProtocol) {
        DispatchQueue.global(qos: .userInitiated).async {
            service.checkBalances {[weak self] (response, error) in
                guard let self = self else { return }
                if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue {
                    self.presenter.didFailedToLoad(error: errorValue.message)
                } else if let balanceObj = response {
                    self.presenter.showBalance(response: balanceObj)
                }
            }
        }
    }
    
    func getAllTransactions(service: ServiceProtocol) {
        DispatchQueue.global(qos: .userInitiated).async {
            service.getAllTransactions {[weak self] (response,error) in
                guard let self = self else { return }
                if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue{
                    self.presenter.didFailedToLoad(error: errorValue.message)
                } else if let transactions = response {
                    self.presenter.showTransactions(response: transactions)
                }
            }
        }
    }
}

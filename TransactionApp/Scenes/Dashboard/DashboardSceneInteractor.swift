//
//  DashboardSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

final class DashboardSceneInteractor {
    let service: ServiceProtocol = APIService(APIManager())
    var presenter: DashboardScenePresentationLogic?
}


// MARK: - DashboardSceneBusinessLogic
extension DashboardSceneInteractor: DashboardSceneBussinessLogic {
    func checkBalance() {
        self.service.checkBalances {[weak self] (response, error) in
            guard let self = self else { return }
            if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue {
                self.presenter?.didFailedToLoad(error: errorValue.message)
            } else if let balanceObj = response {
                self.presenter?.showBalance(response: balanceObj)
            }
        }
    }
    
    func getAllTransactions() {
        self.service.getAllTransactions {[weak self] (response,error) in
            guard let self = self else { return }
            if let errorValue = error, errorValue.statusCode != ResponseCodes.success.rawValue{
                self.presenter?.didFailedToLoad(error: errorValue.message)
            } else if let transactions = response {
                self.presenter?.showTransactions(response: transactions)
            }
        }
    }
}

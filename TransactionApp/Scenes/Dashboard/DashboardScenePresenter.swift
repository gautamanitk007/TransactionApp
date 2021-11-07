//
//  DashboardScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol DashboardScenePresentationLogic {
    func showTransactions(response: TransactionResponse)
    func showBalance(response:BalanceResponse)
    func didFailedToLoad( error: String?)
}

final class DashboardScenePresenter {
  private weak var viewController: DashboardSceneDisplayLogic?
  
  init(viewController: DashboardSceneDisplayLogic?) {
        self.viewController = viewController
  }
}


// MARK: - DashboardScenePresentationLogic
extension DashboardScenePresenter: DashboardScenePresentationLogic {
    func showTransactions(response: TransactionResponse){
        print("Transactions:\(response)")
    }
    func showBalance(response: BalanceResponse) {
        print("Balance:\(response)")
    }
    func didFailedToLoad( error: String?){
        print("Error:\(error)")
    }
}



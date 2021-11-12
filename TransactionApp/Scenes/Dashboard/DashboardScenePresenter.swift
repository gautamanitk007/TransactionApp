//
//  DashboardScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation


typealias DashboardScenePresenterInput = DashboardSceneInteractorOutput
typealias DashboardScenePresenterOutput = DashboardSceneViewControllerInput

final class DashboardScenePresenter {
    weak var viewController: DashboardScenePresenterOutput?
}


// MARK: - DashboardScenePresentationLogic
extension DashboardScenePresenter: DashboardScenePresenterInput {
    func showTransactions(response: TransactionResponse){
        var accTrans = [TransactionViewModel]()
        if let accounts = response.data {
            accTrans = self.createViewModel(for: accounts)
        }
        
        self.viewController?.displayTransactionListViewModel(accTrans)
    }
    func showBalance(response: BalanceResponse) {
        TransactionManager.shared.totalBalance = Float(response.balance!)
        self.viewController?.displayBalanceViewModel(BalanceViewModel(balance: "S$ \(response.balance!)"))
    }
    func didFailedToLoad( error: String?){
        self.viewController?.displayError(error ?? Utils.getLocalisedValue(key:"Unkown"))
    }
}


private extension DashboardScenePresenter {
    func createViewModel(for accs:[Account]) -> [TransactionViewModel] {
        var transations = [TransactionViewModel]()
        for account in accs {
            guard let isoDate = account.date, let date = isoDate.dateFromISO8601 else {
                continue
            }
            let accTrans = TransactionViewModel(acc: account,date: date)
            transations.append(accTrans)
            
        }
        return transations.sorted { (acc1, acc2) -> Bool in
            return acc1.date > acc2.date
        }
    }
}

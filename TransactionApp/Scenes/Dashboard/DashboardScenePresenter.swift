//
//  DashboardScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

final class DashboardScenePresenter {
    weak var viewController: DashboardSceneDisplayLogic?
}

// MARK: - DashboardScenePresentationLogic
extension DashboardScenePresenter: DashboardScenePresentationLogic {
    func showTransactions(response: DashboardSceneDataModel.TransactionResponse){
        var accTrans = [DashboardSceneDataModel.TransactionViewModel]()
        if let accounts = response.data {
            accTrans = self.createViewModel(for: accounts)
        }
        
        self.viewController?.displayTransactionListViewModel(viewModels: accTrans)
    }
    func showBalance(response: DashboardSceneDataModel.BalanceResponse) {
        TransactionManager.shared.totalBalance = Float(response.balance!)
        self.viewController?.displayBalanceViewModel(viewModel: DashboardSceneDataModel.BalanceViewModel(balance: "S$ \(response.balance!)"))
    }
    func didFailedToLoad( error: String?){
        self.viewController?.displayError(error ?? Utils.getLocalisedValue(key:"Unkown"))
    }
}


private extension DashboardScenePresenter {
    func createViewModel(for accs:[DashboardSceneDataModel.Account]) -> [DashboardSceneDataModel.TransactionViewModel] {
        var transations = [DashboardSceneDataModel.TransactionViewModel]()
        for account in accs {
            guard let isoDate = account.date, let date = isoDate.dateFromISO8601 else {
                continue
            }
            let accTrans = DashboardSceneDataModel.TransactionViewModel(acc: account,date: date)
            transations.append(accTrans)
        }
        return transations.sorted { (acc1, acc2) -> Bool in
            return acc1.date > acc2.date
        }
    }
}

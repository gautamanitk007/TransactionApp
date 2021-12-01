//
//  DashboardProtocols.swift
//  TransactionApp
//
//  Created by Gautam Singh on 1/12/21.
//

import Foundation


protocol DashboardSceneDisplayLogic: AnyObject {
    func displayBalanceViewModel(viewModel:DashboardSceneDataModel.BalanceViewModel)
    func displayTransactionListViewModel(viewModels:[DashboardSceneDataModel.TransactionViewModel])
    func displayError(_ error:String)
}

protocol DashboardSceneBussinessLogic:AnyObject {
    func checkBalance()
    func getAllTransactions()
}

protocol DashboardScenePresentationLogic:AnyObject {
    func showTransactions(response: DashboardSceneDataModel.TransactionResponse)
    func showBalance(response:DashboardSceneDataModel.BalanceResponse)
    func didFailedToLoad( error: String?)
}


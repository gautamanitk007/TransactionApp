//
//  TransferSceneProtocol.swift
//  TransactionApp
//
//  Created by Gautam Singh on 1/12/21.
//

import Foundation
protocol TransferSceneDisplayLogic:AnyObject {
    func dispayPayee(payeeList:[TransferSceneDataModel.Payee])
    func displayError(_ error:String)
    func transferSuccess(msg:String)
}
protocol TransferSceneBusinessLogic:AnyObject {
    func getAllPayee()
    func transferTo(payee:TransferSceneDataModel.TransferSceneViewModel)
}
protocol TransferScenePresentationLogic:AnyObject {
    func showPayeeList(response: TransferSceneDataModel.PayeeResponse)
    func showErrorMessage( error: String?)
    func transferSuccess(response:TransferSceneDataModel.TransferResponse)
}

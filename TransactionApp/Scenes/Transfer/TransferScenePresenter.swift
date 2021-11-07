//
//  TransferScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol TransferScenePresentationLogic {
  func presentResponse(_ response: TransferSceneModel.Response)
}

final class TransferScenePresenter {
  private weak var viewController: TransferSceneDisplayLogic?
  
  init(viewController: TransferSceneDisplayLogic?) {
    self.viewController = viewController
  }
}


// MARK: - TransferScenePresentationLogic
extension TransferScenePresenter: TransferScenePresentationLogic {
  
  func presentResponse(_ response: TransferSceneModel.Response) {
    
    switch response {
      
    case .doSomething(let newItem, let isItem):
      presentDoSomething(newItem, isItem)
    }
  }
}


// MARK: - Private Zone
private extension TransferScenePresenter {
  
  func presentDoSomething(_ newItem: Int, _ isItem: Bool) {
    
    //prepare data for display and send it further
    
    viewController?.displayViewModel(.doSomething(viewModelData: NSObject()))
  }
}

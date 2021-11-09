//
//  TransferSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

typealias TransferSceneInteractable = TransferSceneBusinessLogic

protocol TransferSceneBusinessLogic {
  
  func doRequest(_ request: TransferSceneModel.Request)
}

final class TransferSceneInteractor {
  
  private var presenter: TransferScenePresentationLogic
  
  init(viewController: TransferSceneDisplayLogic?) {
   
    self.presenter = TransferScenePresenter(viewController: viewController)
  }
}


// MARK: - TransferSceneBusinessLogic
extension TransferSceneInteractor: TransferSceneBusinessLogic {
  
  func doRequest(_ request: TransferSceneModel.Request) {
    
  }
}


// MARK: - Private Zone
private extension TransferSceneInteractor {
  
  
}

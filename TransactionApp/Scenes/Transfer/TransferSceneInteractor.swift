//
//  TransferSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

typealias TransferSceneInteractable = TransferSceneBusinessLogic & TransferSceneDataStore

protocol TransferSceneBusinessLogic {
  
  func doRequest(_ request: TransferSceneModel.Request)
}

protocol TransferSceneDataStore {
  var dataSource: TransferSceneModel.DataSource { get }
}

final class TransferSceneInteractor: TransferSceneDataStore {
  
  var dataSource: TransferSceneModel.DataSource
  
  private var presenter: TransferScenePresentationLogic
  
  init(viewController: TransferSceneDisplayLogic?, dataSource: TransferSceneModel.DataSource) {
    self.dataSource = dataSource
    self.presenter = TransferScenePresenter(viewController: viewController)
  }
}


// MARK: - TransferSceneBusinessLogic
extension TransferSceneInteractor: TransferSceneBusinessLogic {
  
  func doRequest(_ request: TransferSceneModel.Request) {
    DispatchQueue.global(qos: .userInitiated).async {
      
      switch request {
        
      case .doSomething(let item):
        self.doSomething(item)
      }
    }
  }
}


// MARK: - Private Zone
private extension TransferSceneInteractor {
  
  func doSomething(_ item: Int) {
    
    //construct the Service right before using it
    //let serviceX = factory.makeXService()
    
    // get new data async or sync
    //let newData = serviceX.getNewData()
    
    presenter.presentResponse(.doSomething(newItem: item + 1, isItem: true))
  }
}

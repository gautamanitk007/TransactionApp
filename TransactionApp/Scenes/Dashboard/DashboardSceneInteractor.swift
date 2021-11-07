//
//  DashboardSceneInteractor.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

typealias DashboardSceneInteractable = DashboardSceneBusinessLogic & DashboardSceneDataStore

protocol DashboardSceneBusinessLogic {
  
  func doRequest(_ request: DashboardSceneModel.Request)
}

protocol DashboardSceneDataStore {
  var dataSource: DashboardSceneModel.DataSource { get }
}

final class DashboardSceneInteractor: DashboardSceneDataStore {
  
  var dataSource: DashboardSceneModel.DataSource
  
  private var presenter: DashboardScenePresentationLogic
  
  init(viewController: DashboardSceneDisplayLogic?, dataSource: DashboardSceneModel.DataSource) {
    self.dataSource = dataSource
    self.presenter = DashboardScenePresenter(viewController: viewController)
  }
}


// MARK: - DashboardSceneBusinessLogic
extension DashboardSceneInteractor: DashboardSceneBusinessLogic {
  
  func doRequest(_ request: DashboardSceneModel.Request) {
    DispatchQueue.global(qos: .userInitiated).async {
      
      switch request {
        
      case .doSomething(let item):
        self.doSomething(item)
      }
    }
  }
}


// MARK: - Private Zone
private extension DashboardSceneInteractor {
  
  func doSomething(_ item: Int) {
    
    //construct the Service right before using it
    //let serviceX = factory.makeXService()
    
    // get new data async or sync
    //let newData = serviceX.getNewData()
    
    presenter.presentResponse(.doSomething(newItem: item + 1, isItem: true))
  }
}

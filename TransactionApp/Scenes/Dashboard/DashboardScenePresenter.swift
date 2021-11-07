//
//  DashboardScenePresenter.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol DashboardScenePresentationLogic {
  func presentResponse(_ response: DashboardSceneModel.Response)
}

final class DashboardScenePresenter {
  private weak var viewController: DashboardSceneDisplayLogic?
  
  init(viewController: DashboardSceneDisplayLogic?) {
        self.viewController = viewController
  }
}


// MARK: - DashboardScenePresentationLogic
extension DashboardScenePresenter: DashboardScenePresentationLogic {
  
  func presentResponse(_ response: DashboardSceneModel.Response) {
    
    switch response {
      
    case .doSomething(let newItem, let isItem):
      presentDoSomething(newItem, isItem)
    }
  }
}


// MARK: - Private Zone
private extension DashboardScenePresenter {
  
  func presentDoSomething(_ newItem: Int, _ isItem: Bool) {
    
    //prepare data for display and send it further
    
    viewController?.displayViewModel(.doSomething(viewModelData: NSObject()))
  }
}

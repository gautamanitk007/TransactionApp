//
//  DashboardSceneModel.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.



import Foundation

enum DashboardSceneModel {
  
  enum Request {
    case doSomething(item: Int)
  }
  
  enum Response {
    case doSomething(newItem: Int, isItem: Bool)
  }
  
  enum ViewModel {
    case doSomething(viewModelData: NSObject)
  }
  
  enum Route {
    case dismissDashboardSceneScene
    case xScene(xData: Int)
  }
  
  struct DataSource {
    //var test: Int
  }
}

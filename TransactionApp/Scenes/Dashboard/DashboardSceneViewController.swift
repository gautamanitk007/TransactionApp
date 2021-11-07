//
//  DashboardSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol DashboardSceneDisplayLogic where Self: UIViewController {
  
  func displayViewModel(_ viewModel: DashboardSceneModel.ViewModel)
}

final class DashboardSceneViewController: UIViewController {
  
  //private var interactor: DashboardSceneInteractable!
  //private var router: DashboardSceneRouting!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = false
    //interactor = DashboardSceneInteractor(viewController: self, dataSource: dataSource)
    //router = DashboardSceneRouter(viewController: self)
  }
  
 
}


// MARK: - DashboardSceneDisplayLogic
extension DashboardSceneViewController: DashboardSceneDisplayLogic {
  
  func displayViewModel(_ viewModel: DashboardSceneModel.ViewModel) {
    DispatchQueue.main.async {
      switch viewModel {
        
      case .doSomething(let viewModel):
        self.displayDoSomething(viewModel)
      }
    }
  }
}


// MARK: - DashboardSceneViewDelegate
extension DashboardSceneViewController: DashboardSceneViewDelegate {
  
  func sendDataBackToParent(_ data: Data) {
    //usually this delegate takes care of users actions and requests through UI
    
    //do something with the data or message send back from mainView
  }
}


// MARK: - Private Zone
private extension DashboardSceneViewController {
  
  func displayDoSomething(_ viewModel: NSObject) {
    print("Use the mainView to present the viewModel")
    //example of using router
    //router.routeTo(.xScene(xData: 22))
  }
}

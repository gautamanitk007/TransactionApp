//
//  TransferSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol TransferSceneDisplayLogic where Self: UIViewController {
  
  func displayViewModel(_ viewModel: TransferSceneModel.ViewModel)
}

final class TransferSceneViewController: UIViewController {
  
  private let mainView: TransferSceneView
  private var interactor: TransferSceneInteractable!
  private var router: TransferSceneRouting!
  
  init(mainView: TransferSceneView, dataSource: TransferSceneModel.DataSource) {
    self.mainView = mainView
    
    super.init(nibName: nil, bundle: nil)
    interactor = TransferSceneInteractor(viewController: self, dataSource: dataSource)
    router = TransferSceneRouter(viewController: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //interactor.doSomething(item: 22)
  }
  
  override func loadView() {
    view = mainView
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented, You should't initialize the ViewController through Storyboards")
  }
}


// MARK: - TransferSceneDisplayLogic
extension TransferSceneViewController: TransferSceneDisplayLogic {
  
  func displayViewModel(_ viewModel: TransferSceneModel.ViewModel) {
    DispatchQueue.main.async {
      switch viewModel {
        
      case .doSomething(let viewModel):
        self.displayDoSomething(viewModel)
      }
    }
  }
}


// MARK: - TransferSceneViewDelegate
extension TransferSceneViewController: TransferSceneViewDelegate {
  
  func sendDataBackToParent(_ data: Data) {
    //usually this delegate takes care of users actions and requests through UI
    
    //do something with the data or message send back from mainView
  }
}


// MARK: - Private Zone
private extension TransferSceneViewController {
  
  func displayDoSomething(_ viewModel: NSObject) {
    print("Use the mainView to present the viewModel")
    //example of using router
    router.routeTo(.xScene(xData: 22))
  }
}

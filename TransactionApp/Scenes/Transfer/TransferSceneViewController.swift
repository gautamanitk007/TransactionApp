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

  private var interactor: TransferSceneInteractable!
  private var router: TransactionSceneRouting!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //interactor.doSomething(item: 22)
  }
  
}


// MARK: - TransferSceneDisplayLogic
extension TransferSceneViewController: TransferSceneDisplayLogic {
  
  func displayViewModel(_ viewModel: TransferSceneModel.ViewModel) {
    
  }
}



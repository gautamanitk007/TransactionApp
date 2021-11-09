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
    self.setup()
  }
  
    @objc func submitTapped(){
        
    }
    
}


// MARK: - TransferSceneDisplayLogic
extension TransferSceneViewController: TransferSceneDisplayLogic {
  
  func displayViewModel(_ viewModel: TransferSceneModel.ViewModel) {
    
  }
}

private extension TransferSceneViewController {
    func setup(){
        let apiManager = APIManager()
        interactor = TransferSceneInteractor(viewController: self)
        router = TransactionSceneRouter(viewController: self)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = false
        self.navigationItem.title =  NSLocalizedString("Page_Transfer_Title",comment: "")
        
        let logoutButton = UIBarButtonItem(title: NSLocalizedString("Button_Submit_Title",comment: ""),
                       style: .plain, target: self, action: #selector(TransferSceneViewController.submitTapped))
        self.navigationItem.rightBarButtonItem = logoutButton
        
    }
}



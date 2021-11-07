//
//  DashboardSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol DashboardSceneDisplayLogic where Self: UIViewController {
  
    func displayBalanceViewModel(_ viewModel: DashboardSceneModel.BalanceViewModel)
    func dispalyTransactionListViewModel(_ viewModels: DashboardSceneModel.TransactionList)
}

final class DashboardSceneViewController: UIViewController {
  
    @IBOutlet weak var btnTransfer: RoundedButton!
    @IBOutlet weak var activityTable: UITableView!
    @IBOutlet weak var lblAmount: UILabel!
    
    private var interactor: DashboardSceneInteractable!
    private var router: DashboardSceneRouting!
    private var apiManager: APIManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchBalance()
        self.fetchAllTransactions()
    }
    
    @objc func logoutTapped(_ sender: Any) {
        self.router.popToPrevious()
    }
 
    @IBAction func didTransferTapped(_ sender: Any) {
        self.router.navigateToDestination(for: "ShowTransfer")
    }
}


// MARK: - DashboardSceneDisplayLogic
extension DashboardSceneViewController: DashboardSceneDisplayLogic {

    func displayBalanceViewModel(_ viewModel: DashboardSceneModel.BalanceViewModel){
        
    }
    func dispalyTransactionListViewModel(_ viewModels: DashboardSceneModel.TransactionList){
        
    }
}

// MARK: - Private Zone
private extension DashboardSceneViewController {
    
    func setup(){
        apiManager = APIManager()
        interactor = DashboardSceneInteractor(viewController: self)
        router = DashboardSceneRouter(viewController: self)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title =  NSLocalizedString("Page_Dashboard_Title",comment: "")
        
        let logoutButton = UIBarButtonItem(title: NSLocalizedString("Button_Logout_Title",comment: ""),
                       style: .plain, target: self, action: #selector(DashboardSceneViewController.logoutTapped))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    func fetchBalance() {
        let apiService = APIService(apiManager, EndPoints.balances)
        self.interactor.checkBalance(service: apiService)
    }
    
    func fetchAllTransactions(){
        let apiService = APIService(apiManager, EndPoints.transactions)
        self.interactor.getAllTransactions(service: apiService)
    }
}

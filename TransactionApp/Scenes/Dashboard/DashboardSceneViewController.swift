//
//  DashboardSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

enum Identifier:String {
    case TransactionCellIdentifier = "TransactionCelli"
    case GeneralCellIdentifier = "GeneralCelli"
}

protocol DashboardSceneDisplayLogic where Self: UIViewController {
  
    func displayBalanceViewModel(_ viewModel:BalanceViewModel)
    func displayTransactionListViewModel(_ viewModels:[TransactionViewModel])
    func displayError(_ error:String)
}

final class DashboardSceneViewController: BaseViewController {
  
    @IBOutlet weak var btnTransfer: RoundedButton!
    @IBOutlet weak var activityTable: UITableView!
    @IBOutlet weak var lblAmount: UILabel!
    
    private var interactor: DashboardSceneInteractable!
    private var router: TransactionSceneRouting!
    private var apiManager: APIManager!
    private var datasource : TableViewDatasource<TransactionCell,TransactionViewModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.datasource = TableViewDatasource(cellIdentifier: Identifier.TransactionCellIdentifier.rawValue,
                                              items: []){(cell,viewModel) in
            cell.configure(viewModel)
        }
        self.activityTable.dataSource = self.datasource
        self.startActivity()
        self.fetchBalance()
        self.fetchAllTransactions()
    }
    
    @objc func logoutTapped(_ sender: Any) {
        TransactionManager.shared.token = ""
        self.router.popToPrevious()
    }
 
    @IBAction func didTransferTapped(_ sender: Any) {
        self.router.navigateToDestination(for: "ShowTransfer")
    }
}

// MARK: - DashboardSceneDisplayLogic
extension DashboardSceneViewController: DashboardSceneDisplayLogic {

    func displayBalanceViewModel(_ viewModel: BalanceViewModel){
        DispatchQueue.main.async {
            self.stopActivity()
            self.lblAmount.text = viewModel.balance
        }
    }
    func displayTransactionListViewModel(_ viewModels:[TransactionViewModel]){
        self.datasource.removeAll()
        self.datasource.updateItems(viewModels)
        DispatchQueue.main.async {
            self.stopActivity()
            self.activityTable.reloadData()
        }
    }
    func displayError(_ error:String){
        DispatchQueue.main.async {
            self.stopActivity()
            self.router.showFailure(message: error)
        }
    }
}

// MARK: - Private Zone
private extension DashboardSceneViewController {
    
    func setup(){
        apiManager = APIManager()
        interactor = DashboardSceneInteractor(viewController: self)
        router = TransactionSceneRouter(viewController: self)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = Utils.getLocalisedValue(key:"Page_Dashboard_Title")
        
        let logoutButton = UIBarButtonItem(title:Utils.getLocalisedValue(key:"Button_Logout_Title"),
                       style: .plain, target: self, action: #selector(DashboardSceneViewController.logoutTapped))
        self.navigationItem.rightBarButtonItem = logoutButton
        self.activityTable.layer.borderWidth = 2
        self.activityTable.layer.borderColor = UIColor.systemGroupedBackground.cgColor
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


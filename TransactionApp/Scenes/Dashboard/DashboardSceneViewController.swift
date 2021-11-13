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

protocol DashboardSceneViewControllerInput: AnyObject {
    func displayBalanceViewModel(_ viewModel:BalanceViewModel)
    func displayTransactionListViewModel(_ viewModels:[TransactionViewModel])
    func displayError(_ error:String)
}

protocol DashboardSceneViewControllerOutput:AnyObject {
    func checkBalance()
    func getAllTransactions()
}
final class DashboardSceneViewController: BaseViewController {
  
    @IBOutlet weak var btnTransfer: RoundedButton!
    @IBOutlet weak var activityTable: UITableView!
    @IBOutlet weak var lblAmount: UILabel!
    
    var interactor: DashboardSceneInteractorInput!
    var router: DashboardSceneRouting!
    var datasource : TableViewDatasource<TransactionCell,TransactionViewModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.datasource = TableViewDatasource(cellIdentifier: Identifier.TransactionCellIdentifier.rawValue,
                                              items: []){(cell,viewModel) in
            cell.configure(viewModel)
        }
        self.activityTable.dataSource = self.datasource
        self.activityTable.delegate = self
        self.startActivity()
        self.refreshPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblAmount.text = "S$\(TransactionManager.shared.totalBalance)"
    }
    
    @objc func logoutTapped(_ sender: Any) {
        TransactionManager.shared.token = ""
        self.router.popToPrevious()
    }
 
    @IBAction func didTransferTapped(_ sender: Any) {
        self.router.showNextController()
    }
    @objc func refreshPage(){
        self.startActivity()
        self.fetchBalance()
        self.fetchAllTransactions()
    }
}

// MARK: - DashboardSceneViewControllerInput
extension DashboardSceneViewController: DashboardSceneViewControllerInput{

    func displayBalanceViewModel(_ viewModel: BalanceViewModel){
        self.stopActivity()
        self.lblAmount.text = viewModel.balance
    }
    func displayTransactionListViewModel(_ viewModels:[TransactionViewModel]){
        self.datasource.removeAll()
        self.datasource.updateItems(viewModels)
        self.stopActivity()
        self.activityTable.reloadData()
    }
    func displayError(_ error:String){
        self.stopActivity()
        self.router.showFailure(message: error)
    }
}

// MARK: - Private 
private extension DashboardSceneViewController {
    func setup(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = Utils.getLocalisedValue(key:"Page_Dashboard_Title")
        
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout.png"),
                                           style: .plain, target: self,
                                           action: #selector(DashboardSceneViewController.logoutTapped))
        self.navigationItem.leftBarButtonItem = logoutButton
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh,
                                        target: self, action: #selector(DashboardSceneViewController.refreshPage))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        self.activityTable.layer.borderWidth = 2
        self.activityTable.layer.borderColor = UIColor.systemGroupedBackground.cgColor
    }
    
    func fetchBalance() {
        self.interactor.checkBalance()
    }
    func fetchAllTransactions(){
        self.interactor.getAllTransactions()
    }
}

extension DashboardSceneViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
    }
}

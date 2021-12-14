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



final class DashboardSceneViewController: BaseViewController {
  
    @IBOutlet weak var btnTransfer: RoundedButton!
    @IBOutlet weak var activityTable: UITableView!
    @IBOutlet weak var lblAmount: UILabel!
    
    var interactor: DashboardSceneBussinessLogic?
    var router: DashboardSceneRoutingLogic?
    var datasource : TableViewDatasource<TransactionCell,DashboardSceneDataModel.TransactionViewModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupDashboardViewLogic()
        self.startActivity()
        self.refreshPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblAmount.text = "S$\(TransactionManager.shared.totalBalance)"
    }
    
    deinit {
        self.router = nil
        self.datasource = nil
        self.interactor = nil        
    }
    
    @objc func logoutTapped(_ sender: Any) {
        TransactionManager.shared.token = ""
        self.router?.popToRootController()
    }
 
    @IBAction func didTransferTapped(_ sender: Any) {
        self.router?.showNextController()
    }
    @objc func refreshPage(){
        self.startActivity()
        self.fetchBalance()
        self.fetchAllTransactions()
    }
}

// MARK: - DashboardSceneDisplayLogic
extension DashboardSceneViewController: DashboardSceneDisplayLogic{

    func displayBalanceViewModel(viewModel: DashboardSceneDataModel.BalanceViewModel){
        self.stopActivity()
        self.lblAmount.text = viewModel.balance
    }
    func displayTransactionListViewModel(viewModels:[DashboardSceneDataModel.TransactionViewModel]){
        self.datasource.removeAll()
        self.datasource.updateItems(viewModels)
        self.stopActivity()
        self.activityTable.reloadData()
    }
    func displayError(_ error:String){
        self.stopActivity()
        self.router?.showFailure(message: error)
    }
}

// MARK: - Private 
private extension DashboardSceneViewController {
    func setupDashboardViewLogic() {
        let viewController = self
        let interactor = DashboardSceneInteractor()
        let presenter = DashboardScenePresenter()
        let router = DashboardSceneRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        viewController.datasource = TableViewDatasource(cellIdentifier: Identifier.TransactionCellIdentifier.rawValue,
                                              items: []){(cell,viewModel) in
            cell.configure(viewModel: viewModel)
        }
        self.activityTable.dataSource = viewController.datasource
        self.activityTable.delegate = viewController
    }
    func setupUI(){
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
        self.interactor?.checkBalance()
    }
    func fetchAllTransactions(){
        self.interactor?.getAllTransactions()
    }
}

// MARK: - UITableViewDelegate
extension DashboardSceneViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
    }
}

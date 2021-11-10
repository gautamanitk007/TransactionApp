//
//  DropdownViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 10/11/21.
//

import UIKit


protocol DropdownViewControllerDelegate:AnyObject {
    func didSelected(payee:Payee)
}

class DropdownViewController: UIViewController {
    @IBOutlet weak var customTable: UITableView!
    var payeeList:[Payee]!
    weak var delegate:DropdownViewControllerDelegate?
    private var datasource : TableViewDatasource<GeneralCell,Payee>!
    var contentSize:CGSize?{
        didSet{
            self.preferredContentSize = contentSize!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = TableViewDatasource(cellIdentifier: Identifier.GeneralCellIdentifier.rawValue,items:self.payeeList){(cell,model) in
            cell.configure(model)
        }
        self.customTable.dataSource = self.datasource
        self.customTable.delegate = self
        contentSize = CGSize.init(width: 160, height: 260)
    }
    
    deinit {
        self.datasource = nil
        self.payeeList = nil
    }
}
//MARK:- UITableViewDelegate
extension DropdownViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelected(payee: self.payeeList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

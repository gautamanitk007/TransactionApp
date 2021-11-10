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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = TableViewDatasource(cellIdentifier: Identifier.GeneralCellIdentifier.rawValue,items:self.payeeList){(cell,model) in
            cell.configure(model)
        }
        self.customTable.dataSource = self.datasource
        self.customTable.delegate = self
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    deinit {
        self.datasource = nil
        self.payeeList = nil
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == self.view {
            dismiss(animated: true, completion: nil)
        }
    }
}
//MARK:- UITableViewDelegate
extension DropdownViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelected(payee: self.payeeList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}


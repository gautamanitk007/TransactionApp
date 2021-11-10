//
//  TableViewDatasource.swift
//  TransactionApp
//
//  Created by Gautam Singh on 8/11/21.
//

import Foundation
import UIKit

class TableViewDatasource<CellType,Model>:NSObject,UITableViewDataSource where CellType : UITableViewCell{
    let cellIdentifier: String
    var items: [Model]
    let configureCell: (CellType, Model) -> ()
   
    init(cellIdentifier: String,items: [Model], configureCell: @escaping (CellType,Model) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    
    }
    func removeAll() {
        self.items.removeAll()
    }
    func updateItems(_ items: [Model]) {
        self.items = items
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell with identifier \(self.cellIdentifier) not found")
        }
        let vm = self.items[indexPath.row]
        self.configureCell(cell, vm)
        return cell
    }
   
}

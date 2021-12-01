//
//  GeneralCell.swift
//  TransactionApp
//
//  Created by Gautam Singh on 10/11/21.
//

import UIKit

class GeneralCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(payee: TransferSceneDataModel.Payee){
        self.lblName.text = payee.accountHolderName
    }
}


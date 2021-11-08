//
//  TransactionCell.swift
//  TransactionApp
//
//  Created by Gautam Singh on 8/11/21.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblToFromMsg: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ ts: ViewTransaction){
        self.lblDay.text = ts.dayMonth
        self.lblToFromMsg.text = ts.payToFrom
        self.lblAmount.attributedText = ts.amount
    }
}

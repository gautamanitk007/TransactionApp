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
    @IBOutlet weak var placeHolderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.placeHolderView.layer.cornerRadius = 10
        self.placeHolderView.layer.borderWidth = 2
        self.placeHolderView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ ts: TransactionViewModel){
        self.lblDay.text = ts.dayMonth
        self.lblToFromMsg.text = ts.payToFrom
        self.lblAmount.attributedText = ts.amount
    }
}

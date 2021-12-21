//
//  HybridTextView.swift
//  TransactionApp
//
//  Created by Gautam Singh on 18/12/21.
//

import Foundation
import UIKit
class HybridTextView: UIView {
    @IBOutlet weak var lblHeader:UILabel!
    @IBOutlet weak var lblFooter:UILabel!
    @IBOutlet weak var bindTextField:BindingTextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        self.lblFooter?.text = "footer"
        self.lblHeader?.text = "header"
        self.bindTextField?.text = "textField"
    }
}

extension UIView {
    func fixInView(_ containerView: UIView){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = containerView.frame
        self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 8).isActive = true
        self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8).isActive = true
    }
}

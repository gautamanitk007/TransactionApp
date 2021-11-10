//
//  BaseViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import UIKit

class BaseViewController: UIViewController {

    var activityView: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityView = UIActivityIndicatorView()
        self.activityView?.color = .red
        self.activityView?.style = .large
        self.activityView?.translatesAutoresizingMaskIntoConstraints = false
        self.activityView?.hidesWhenStopped = true
        self.view.addSubview(self.activityView!)
        
        self.activityView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.activityView?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        self.activityView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.activityView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)

    }
    @objc func keyboardWillShow(_ notification: Notification) {
       
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        
    }
    func startActivity(){
        if self.activityView?.isAnimating == false {
            self.activityView?.startAnimating()
        }
    }
    func stopActivity(){
        if self.activityView?.isAnimating == true {
            self.activityView?.stopAnimating()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
}

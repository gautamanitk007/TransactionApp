//
//  LoginSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
protocol LoginSceneViewControllerInput: AnyObject {
    func loginSuccess()
    func loginFailed(message: String)
}

protocol LoginSceneViewControllerOutput:AnyObject {
    func startLogin(user userModel: UserModel)
}

final class LoginSceneViewController: BaseViewController {
    
    var interactor: LoginSceneInteractorInput!
    var router: LoginSceneRoutingLogic!
    var userModel: UserModel?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var baseScrollView: UIScrollView!
    @IBOutlet weak var txtPassword: BindingTextField!{
        didSet{
            txtPassword.bind{self.userModel?.password = $0}
        }
    }
    @IBOutlet weak var txtUsername: BindingTextField!{
        didSet{
            txtUsername.bind{self.userModel?.username = $0}
        }
    }
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @objc override func keyboardWillShow(_ notification: Notification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 40, right: 0)
        self.baseScrollView.contentInset = contentInsets
        self.baseScrollView.scrollIndicatorInsets = contentInsets
    }
    @objc override func keyboardWillHide(_ notification: Notification) {
        self.baseScrollView.contentInset = .zero
        self.baseScrollView.scrollIndicatorInsets = .zero
    }
    @IBAction func didLoginTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.startActivity()
        interactor.startLogin(user: self.userModel!)
    }
}


// MARK: - LoginSceneDisplayLogic
extension LoginSceneViewController: LoginSceneViewControllerInput {
    func loginSuccess() {
        self.stopActivity()
        self.router.showLoginSuccess()
    }
    func loginFailed(message: String) {
        self.stopActivity()
        self.router.showLogingFailure(message: message)
    }
}



// MARK: - Private Zone
private extension LoginSceneViewController {
    func setup() {
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        self.txtUsername.placeholder = Utils.getLocalisedValue(key:"Login_Text_Field_Placeholder")
        self.txtPassword.placeholder = Utils.getLocalisedValue(key:"Password_Text_Field_Placeholder")
        self.btnLogin.setTitle(Utils.getLocalisedValue(key:"Login_Button_Title"), for: .normal)
    }
}

//MARK:- UITextFieldDelegate
extension LoginSceneViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtUsername {
            self.txtPassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return false
    }
}

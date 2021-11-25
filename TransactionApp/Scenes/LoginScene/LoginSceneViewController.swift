//
//  LoginSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit


final class LoginSceneViewController: BaseViewController {
    
    var interactor: LoginSceneInteractorInput!
    var router: LoginSceneRouting!
    var userModel: LoginSceneDataModel.Request?

    @IBOutlet weak var containerView: RoundedView!
    
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
    @IBAction func didLoginTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.startActivity()
        interactor.startLogin(request: self.userModel!)
    }
}


// MARK: - LoginSceneViewControllerInput
extension LoginSceneViewController: LoginSceneViewControllerInput {
    func dispayLoginSuccess(messgae:String){
        self.stopActivity()
        self.router.showLoginSuccess()
    }
    func displayLoginFailed(message: String){
        self.stopActivity()
        self.router.showFailure(message: message)
    }
}
// MARK: - Private 
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

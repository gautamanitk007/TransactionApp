//
//  LoginSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit


final class LoginSceneViewController: BaseViewController {
    
    var interactor: LoginSceneBusinessLogic?
    var router: LoginSceneRoutingLogic?
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
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logicSetup()
        self.setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func didLoginTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.startActivity()
        self.interactor?.startLogin(request: self.userModel!)
    }
    @IBAction func didRegisterTapped(_ sender: Any) {
        self.router?.showRegister()
    }
}


// MARK: - LoginSceneViewControllerInput
extension LoginSceneViewController: LoginSceneDisplayLogic{
    func dispayLoginSuccess(viewModel: LoginSceneDataModel.ViewModel){
        self.stopActivity()
        self.router?.showDashboard()
    }
    func displayLoginFailed(viewModel: LoginSceneDataModel.ViewModel){
        self.stopActivity()
        self.router?.showFailure(message: viewModel.error!)
    }
}
// MARK: - Private 
private extension LoginSceneViewController {
    func setupUI() {
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        self.txtUsername.placeholder = Utils.getLocalisedValue(key:"Login_Text_Field_Placeholder")
        self.txtPassword.placeholder = Utils.getLocalisedValue(key:"Password_Text_Field_Placeholder")
        self.btnLogin.setTitle(Utils.getLocalisedValue(key:"Login_Button_Title"), for: .normal)
    }
    func logicSetup() {
        let viewController = self
        let interactor = LoginSceneInteractor()
        let presenter = LoginScenePresenter()
        let router = LoginSceneRouter()
        let model = LoginSceneDataModel.Request()
        viewController.interactor = interactor
        viewController.router = router
        viewController.userModel = model
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
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

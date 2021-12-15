//
//  RegisterSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 14/12/21.

import UIKit

final class RegisterSceneViewController: BaseViewController {
    
    var interactor: RegisterSceneBusinessLogic?
    var router: RegisterSceneRoutingLogic?
    var request: RegisterScene.Request?

    @IBOutlet weak var txtUsername: BindingTextField!{
        didSet{
            txtUsername.bind{self.request?.username = $0}
        }
    }
    @IBOutlet weak var txtPassword: BindingTextField!{
        didSet{
            txtPassword.bind{self.request?.password = $0}
        }
    }
    @IBOutlet weak var txtConfirmPassword: BindingTextField!{
        didSet{
            txtConfirmPassword.bind{self.request?.confirmPassword = $0}
        }
    }
    @IBOutlet weak var btnRegister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.initialise()
    }
    
    @IBAction func didRegisterTapped(_ sender: Any) {
        self.startActivity()
        self.interactor?.registerUser(request: request)
    }
}


private extension RegisterSceneViewController{
    func initialise() {
        let viewController = self
        let interactor = RegisterSceneInteractor()
        let presenter = RegisterScenePresenter()
        let router = RegisterSceneRouter()
        let register = RegisterScene.Request()
        viewController.request = register
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = Utils.getLocalisedValue(key:"Page_Register_Title")
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        self.txtConfirmPassword.delegate = self
        self.txtUsername.placeholder = Utils.getLocalisedValue(key:"Login_Text_Field_Placeholder")
        self.txtPassword.placeholder = Utils.getLocalisedValue(key:"Password_Text_Field_Placeholder")
        self.txtConfirmPassword.placeholder = Utils.getLocalisedValue(key:"Password_Text_Field_Confirm_Placeholder")
        self.btnRegister.setTitle(Utils.getLocalisedValue(key:"Register_Button_Title"), for: .normal)
    }
}

extension RegisterSceneViewController:RegisterSceneDisplayLogic{
    func displayRegisterSuccess(viewModel: RegisterScene.RegisterViewModel) {
        self.stopActivity()
        self.router?.showDashboard()
    }
    
    func displayRegisterFailed(errorViewModel: RegisterScene.ErrorViewModel) {
        self.stopActivity()
        self.router?.showFailure(message: errorViewModel.error)
    }
}
//MARK:- UITextFieldDelegate
extension RegisterSceneViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtUsername {
            self.txtPassword.becomeFirstResponder()
        }else if textField == self.txtPassword{
            self.txtConfirmPassword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

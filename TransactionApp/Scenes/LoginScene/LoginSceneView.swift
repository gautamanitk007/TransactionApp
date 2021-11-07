//
//  LoginSceneView.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//

import UIKit

protocol LoginSceneViewDelegate: class {
    func didLoginButtonTapped(for model: UserModel)
}
class LoginSceneView: UIView {

    @IBOutlet weak var txtPassword: BindingTextField!{
        didSet{
            txtPassword.bind{self.userModel?.password = $0}
        }
    }
    @IBOutlet weak var txtUserId: BindingTextField!{
        didSet{
            txtUserId.bind{self.userModel?.username = $0}
        }
    }
    
    @IBOutlet weak var btnLogin: UIButton!
    private var userModel: UserModel?
    weak var delegate: LoginSceneViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.userModel = UserModel()
    }
    
    @IBAction func didLoginTapped(_ sender: Any) {
        self.endEditing(true)
        guard let model = self.userModel else { return}
        self.delegate?.didLoginButtonTapped(for: model)
    }
    
}


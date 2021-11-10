//
//  TransferSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol TransferSceneDisplayLogic where Self: UIViewController {
    func dispayPayee(payeeList:[Payee])
    func displayError(_ error:String)
}

final class TransferSceneViewController: BaseViewController {

    private var interactor: TransferSceneInteractable!
    private var router: TransactionSceneRouting!
    
    @IBOutlet weak var recipientTextField: UITextField!
    @IBOutlet weak var dateOfTransferTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var btnCancel: RoundedButton!
    @IBOutlet weak var btnSubmit: RoundedButton!
    
    var selectedPayee:Payee?{
        didSet{
            self.recipientTextField.text = selectedPayee?.accountHolderName
        }
    }
    var payeeList: [Payee]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.startActivity()
        self.fetchPayee()
    }
  
    @IBAction func submitTapped(){
        
    }
    
    @IBAction func cancelTapped(){
        self.router.popToPrevious()
    }
    
    @objc func showCalendar(){
        print("show date picker")
    }
    
    @objc func showDropdown(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "showPopover") as! DropdownViewController
        destinationVC.payeeList = self.payeeList
        destinationVC.delegate = self
        destinationVC.modalPresentationStyle = .popover
        self.present(destinationVC, animated: true, completion: nil)
    }
}
private extension TransferSceneViewController {
    func setup(){
        interactor = TransferSceneInteractor(viewController: self)
        router = TransactionSceneRouter(viewController: self)
    
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = false
        self.navigationItem.title =  NSLocalizedString("Page_Transfer_Title",comment: "")
        
        let recipientButton = Utils.createButton(textField: self.recipientTextField, imgName: "drop.png")
        recipientButton.addTarget(self, action: #selector(self.showDropdown), for: .touchUpInside)
        
        let dateOfTransferButton = Utils.createButton(textField: self.dateOfTransferTextField, imgName: "calendar.png")
        dateOfTransferButton.addTarget(self, action: #selector(self.showCalendar), for: .touchUpInside)
        
        self.recipientTextField.placeholder = NSLocalizedString("Recipient_Text_Field_Placeholder",comment: "")
        self.dateOfTransferTextField.placeholder = NSLocalizedString("DateOfTransfer_Text_Field_Placeholder",comment: "")
        self.descTextField.placeholder = NSLocalizedString("Description_Text_Field_Placeholder",comment: "")
        self.amountTextField.placeholder = NSLocalizedString("Amount_Text_Field_Placeholder",comment: "")
        
        for txtField in [self.recipientTextField,self.dateOfTransferTextField,self.descTextField,self.amountTextField] {
            txtField?.delegate = self
        }
        let tapRecipientGesture = UITapGestureRecognizer(target: self, action: #selector(showDropdown))
        self.recipientTextField.addGestureRecognizer(tapRecipientGesture)
        
        let tapCalendarGesture = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
        self.dateOfTransferTextField.addGestureRecognizer(tapCalendarGesture)
        
    }
    func fetchPayee(){
        let apiService = APIService(APIManager(), EndPoints.payees)
        self.interactor.getAllPayee(service: apiService)
    }
   
}
// MARK: - TransferSceneDisplayLogic
extension TransferSceneViewController: TransferSceneDisplayLogic {
    func displayError(_ error: String) {
        DispatchQueue.main.async {
            self.stopActivity()
            self.router.showFailure(message: error)
        }
    }
    
    func dispayPayee(payeeList: [Payee]) {
        DispatchQueue.main.async {
            self.stopActivity()
            self.payeeList = payeeList
        }
    }
}

//MARK:- DropdownViewControllerDelegate
extension TransferSceneViewController : DropdownViewControllerDelegate{
    func didSelected(payee: Payee) {
        self.selectedPayee = payee
    }
}
//MARK:- UITextFieldDelegate
extension TransferSceneViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.recipientTextField {
            self.dateOfTransferTextField.becomeFirstResponder()
        }else if textField == self.dateOfTransferTextField{
            self.descTextField.becomeFirstResponder()
        }else if textField == self.descTextField{
            self.amountTextField.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.recipientTextField || textField == dateOfTransferTextField{
            return false
        }
        return true
    }
}

//
//  TransferSceneViewController.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit


final class TransferSceneViewController: BaseViewController {

    var interactor: TransferSceneBusinessLogic?
    var router: TransferSceneRoutingLogic?
    var transferModel:TransferSceneDataModel.TransferSceneViewModel!
    
    @IBOutlet weak var recipientTextField: BindingTextField!{
        didSet{
            recipientTextField.bind{self.transferModel.recipientAccountNo = $0}
        }
    }
    @IBOutlet weak var dateOfTransferTextField: BindingTextField!{
        didSet{
            dateOfTransferTextField.bind{self.transferModel.date = $0}
        }
    }
    @IBOutlet weak var descTextField: BindingTextField!{
        didSet{
            descTextField.bind{self.transferModel.description = $0}
        }
    }
    @IBOutlet weak var amountTextField: BindingTextField!{
        didSet{
            amountTextField.bind{self.transferModel.amount = $0}
        }
    }
    @IBOutlet weak var btnCancel: RoundedButton!
    @IBOutlet weak var btnSubmit: RoundedButton!
    var datePicker: UIDatePicker?
    var selectedPayee:TransferSceneDataModel.Payee?{
        didSet{
            self.recipientTextField.text = selectedPayee?.accountHolderName
            self.transferModel.recipientAccountNo = selectedPayee?.accountNo
        }
    }
    var payeeList: [TransferSceneDataModel.Payee]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTransferViewLogic()
        self.fetchPayee()
        self.createDatePicker()
    }
  
    deinit {
        self.payeeList?.removeAll()
        self.payeeList = nil
        self.datePicker = nil
        self.selectedPayee = nil
        self.interactor = nil
        self.transferModel = nil
        self.router = nil
    }
    @IBAction func submitTapped(){
        self.startActivity()
        self.interactor?.transferTo(payee: self.transferModel!)
    }
    
    @IBAction func cancelTapped(){
        self.router?.popToPrevious()
    }
    
    @objc func showCalendar(){
        self.dateOfTransferTextField.becomeFirstResponder()
    }
    @objc func pickerDateValue(){
        self.view.endEditing(true)
        if self.datePicker!.date >= Date() {
            let dateValue = self.datePicker!.date.convertToString()
            self.dateOfTransferTextField.text = dateValue
            self.transferModel?.date = dateValue
        }else{
            self.router?.showFailure(message: Utils.getLocalisedValue(key: "Past_Transfer_Date_Msg"))
        }
        
    }
    @objc func showDropdown(){
        guard let pList = self.payeeList, pList.count > 0 else {
            self.router?.showFailure(message: Utils.getLocalisedValue(key: "NoPayee"))
            return
        }
       self.router?.showPopOver(for: "showPopover", popoverList: pList ,delegate: self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == self.view {
            if self.amountTextField.isFirstResponder {
                self.amountTextField.resignFirstResponder()
            }
            if self.descTextField.isFirstResponder {
                self.descTextField.resignFirstResponder()
            }
            if self.dateOfTransferTextField.isFirstResponder {
                self.dateOfTransferTextField.resignFirstResponder()
            }
        }
    }
}
private extension TransferSceneViewController {
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = false
        self.navigationItem.title =  Utils.getLocalisedValue(key:"Page_Transfer_Title")
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh,
                                        target: self, action: #selector(TransferSceneViewController.fetchPayee))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        let recipientButton = Utils.createButton(textField: self.recipientTextField, imgName: "drop.png")
        recipientButton.addTarget(self, action: #selector(self.showDropdown), for: .touchUpInside)
       
        let dateOfTransferButton = Utils.createButton(textField: self.dateOfTransferTextField, imgName: "calendar.png")
        dateOfTransferButton.addTarget(self, action: #selector(self.showCalendar), for: .touchUpInside)
        
        self.recipientTextField.placeholder = Utils.getLocalisedValue(key:"Recipient_Text_Field_Placeholder")
        self.dateOfTransferTextField.placeholder = Utils.getLocalisedValue(key:"DateOfTransfer_Text_Field_Placeholder")
        self.descTextField.placeholder = Utils.getLocalisedValue(key:"Description_Text_Field_Placeholder")
        self.amountTextField.placeholder = Utils.getLocalisedValue(key:"Amount_Text_Field_Placeholder")
        
        for txtField in [self.recipientTextField,self.dateOfTransferTextField,self.descTextField,self.amountTextField] {
            txtField?.delegate = self
        }
        let tapRecipientGesture = UITapGestureRecognizer(target: self, action: #selector(showDropdown))
        self.recipientTextField.addGestureRecognizer(tapRecipientGesture)
    }
    
    func setupTransferViewLogic(){
        let viewController = self
        let interactor = TransferSceneInteractor()
        let presenter = TransferScenePresenter()
        let router = TransferSceneRouter()
        let transferModel = TransferSceneDataModel.TransferSceneViewModel()
        
        viewController.transferModel = transferModel
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    func createDatePicker(){
        self.datePicker = UIDatePicker()
        self.datePicker?.preferredDatePickerStyle = .wheels
        self.datePicker?.datePickerMode = .dateAndTime
        self.datePicker?.translatesAutoresizingMaskIntoConstraints = false
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.barTintColor = .systemBlue
        toolbar.sizeToFit()
        let barBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(TransferSceneViewController.pickerDateValue))
        toolbar.setItems([barBtn], animated: false)
        dateOfTransferTextField.inputAccessoryView = toolbar
        dateOfTransferTextField.inputView = datePicker
    }

    func clearInput(){
        self.amountTextField.text = ""
        self.dateOfTransferTextField.text = ""
        self.descTextField.text = ""
        self.recipientTextField.text = ""
        
        self.transferModel?.amount = ""
        self.transferModel?.recipientAccountNo = ""
        self.transferModel?.date = ""
        self.transferModel?.description = ""
    }
    @objc func fetchPayee(){
        self.startActivity()
        self.interactor?.getAllPayee()
    }
}
// MARK: - TransferSceneDisplayLogic
extension TransferSceneViewController: TransferSceneDisplayLogic {
    func displayError(_ error: String) {
        self.stopActivity()
        self.router?.showFailure(message: error)
    }
    
    func dispayPayee(payeeList: [TransferSceneDataModel.Payee]) {
        self.stopActivity()
        self.payeeList?.removeAll()
        self.payeeList = payeeList
    }
    func transferSuccess(msg:String){
        self.stopActivity()
        self.clearInput()
        self.router?.showSuccess(msg: msg)
    }
}

//MARK:- DropdownViewControllerDelegate
extension TransferSceneViewController : DropdownViewControllerDelegate{
    func didSelected(payee: TransferSceneDataModel.Payee) {
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
        if textField == self.recipientTextField{
            return false
        }
        return true
    }
}

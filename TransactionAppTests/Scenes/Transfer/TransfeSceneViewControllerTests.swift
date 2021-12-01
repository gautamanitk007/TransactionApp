//
//  TransfeSceneViewControllerTests.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import XCTest
@testable import TransactionApp


final class TransferSceneViewControllerTests: XCTestCase {
    private var sut: TransferSceneViewController!
    private var interactor: TransferSceneBusinessLogicMock!
    private var router: TransferSceneRoutingLogicMock!
    override func setUp() {
        super.setUp()
        sut = TransferSceneViewController()
        sut.loadView()
        interactor = TransferSceneBusinessLogicMock()
        sut.interactor = interactor
        router = TransferSceneRoutingLogicMock()
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        super.tearDown()
    }
    
    func test_submitTapped(){
        //Given
        var model = TransferSceneDataModel.TransferSceneViewModel()
        model.amount = "100"
        model.date = Date().convertToString()
        model.description = "Rental"
        model.recipientAccountNo = "111111"
        
        //When
        sut.transferModel = model
        sut.submitTapped()
        
        //Then
        XCTAssertNotNil(interactor.transferModel)
        XCTAssertEqual(interactor.transferModel?.amount, "100")
        XCTAssertEqual(interactor.transferModel?.description, "Rental")
        XCTAssertEqual(interactor.transferModel?.recipientAccountNo, "111111")
        XCTAssertEqual(interactor.transferModel?.date, Date().convertToString())
    }
    
    func test_cancel_tapped(){
        //When
        sut.cancelTapped()
        //Then
        XCTAssertTrue(router.popToPreviousCallback)
    }
    
    func test_picker_future_date_value(){
       //Given
        let futureDate = self.createFutureDate()
        let (recipientTextField,dateOfTransferTextField,descTextField,amountTextField,tModel) = self.create()
        sut.recipientTextField = recipientTextField
        sut.dateOfTransferTextField = dateOfTransferTextField
        sut.descTextField = descTextField
        sut.amountTextField = amountTextField
        sut.transferModel = tModel
        
        sut.viewDidLoad()
        sut.datePicker?.date = futureDate
        //When
        sut.pickerDateValue()
        //Then
        XCTAssertEqual(sut.transferModel.date, futureDate.convertToString())
        XCTAssertEqual(sut.dateOfTransferTextField.text, futureDate.convertToString())
    }
    
    func test_popover_without_payeelist(){
        //Given
        let payeeList = [TransferSceneDataModel.Payee]()
        sut.payeeList = payeeList
        //When
        sut.showDropdown()
        //Then
        XCTAssertEqual(sut.payeeList?.count, 0)
        XCTAssertEqual(router.errMsg, Utils.getLocalisedValue(key: "NoPayee"))
    }
    func test_popover_with_payee_list(){
        //Given
        let bundle = Bundle(for: TransactionAppTests.self)
        guard let payeeObj:TransferSceneDataModel.PayeeResponse = Utils.load(bundle: bundle, fileName: "Payee") else {
            XCTFail()
            return
        }
        let payeeCount = payeeObj.data?.count
        sut.payeeList = payeeObj.data
        //When
        sut.showDropdown()
        //Then
        XCTAssertEqual(sut.payeeList?.count, payeeCount)
        XCTAssertEqual(router.pList.count, payeeCount)
        XCTAssertEqual(router.indentifier, "showPopover")
        
    }
}
private final class TransferSceneBusinessLogicMock: TransferSceneBusinessLogic {
    var isAllPayeeDownloaded:Bool = false
    func getAllPayee() {
       isAllPayeeDownloaded = true
    }
    
    var transferModel: TransferSceneDataModel.TransferSceneViewModel?
    func transferTo(payee: TransferSceneDataModel.TransferSceneViewModel) {
        self.transferModel = payee
    }
}

private final class TransferSceneRoutingLogicMock: TransferSceneRoutingLogic{
    var popToPreviousCallback:Bool = false
    func popToPrevious() {
        popToPreviousCallback = true
    }
    var errMsg:String = ""
    func showFailure(message: String) {
        errMsg = message
    }
    
    func showSuccess(msg: String) {
        
    }
    var indentifier:String = ""
    var pList = [TransferSceneDataModel.Payee]()
    func showPopOver(for indetifier: String, popoverList: [TransferSceneDataModel.Payee], delegate: DropdownViewControllerDelegate) {
        self.indentifier = indetifier
        self.pList = popoverList
    }
}


private extension TransferSceneViewControllerTests{
    func create() -> (BindingTextField,BindingTextField,BindingTextField,BindingTextField,TransferSceneDataModel.TransferSceneViewModel){
        let recipientTextField = BindingTextField()
        let dateOfTransferTextField = BindingTextField()
        let descTextField = BindingTextField()
        let amountTextField = BindingTextField()
        let tModel = TransferSceneDataModel.TransferSceneViewModel()
        return (recipientTextField,dateOfTransferTextField,descTextField,amountTextField,tModel)
    }
    func createFutureDate() -> Date{
        let date = Date()
        var components = DateComponents()
        components.setValue(1, for: .day)
        return Calendar.current.date(byAdding: components, to: date)!
    }
}







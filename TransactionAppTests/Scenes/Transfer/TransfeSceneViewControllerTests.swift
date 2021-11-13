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
    private var interactor: TransferSceneInteractorMock!
    private var router: TransferSceneRoutingMock!
    override func setUp() {
        super.setUp()
        sut = TransferSceneViewController()
        sut.loadView()
        interactor = TransferSceneInteractorMock()
        sut.interactor = interactor
        router = TransferSceneRoutingMock()
        sut.router = router
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        super.tearDown()
    }
    
    func test_viewDidLoad(){
        // Given
        let (recipientTextField,dateOfTransferTextField,descTextField,amountTextField,tModel) = self.create()
        sut.recipientTextField = recipientTextField
        sut.dateOfTransferTextField = dateOfTransferTextField
        sut.descTextField = descTextField
        sut.amountTextField = amountTextField
        sut.transferModel = tModel
        sut.recipientTextField.text = "12345678"
        sut.descTextField.text = "Room Rental"
        sut.dateOfTransferTextField.text = "15-11-2021"
        sut.amountTextField.text = "500"
        //When
        sut.amountTextField.textFieldChange(amountTextField)
        sut.dateOfTransferTextField.textFieldChange(dateOfTransferTextField)
        sut.descTextField.textFieldChange(descTextField)
        sut.recipientTextField.textFieldChange(recipientTextField)
        sut.viewDidLoad()
        //Then
        XCTAssertTrue(sut.activityView!.isAnimating)
        XCTAssertEqual(sut.transferModel.amount, "500")
        XCTAssertEqual(sut.transferModel.date, "15-11-2021")
        XCTAssertEqual(sut.transferModel.recipientAccountNo, "12345678")
        XCTAssertEqual(sut.transferModel.description, "Room Rental")
        XCTAssertNotNil(sut.datePicker)
        XCTAssertTrue(interactor.isAllPayeeDownloaded)
    }
    
    func test_submitTapped(){
        //Given
        var model = TransferSceneModel()
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
    
    func test_picker_date_value(){
       //Given
        let (recipientTextField,dateOfTransferTextField,descTextField,amountTextField,tModel) = self.create()
        sut.recipientTextField = recipientTextField
        sut.dateOfTransferTextField = dateOfTransferTextField
        sut.descTextField = descTextField
        sut.amountTextField = amountTextField
        sut.transferModel = tModel
        sut.viewDidLoad()
        //When
        sut.pickerDateValue()
        //Then
        XCTAssertEqual(sut.transferModel.date, Date().convertToString())
        XCTAssertEqual(sut.dateOfTransferTextField.text, Date().convertToString())
        
    }
    
    func test_show_calendar(){
       //When
       // sut.showCalendar()
    }
    
    
    
}
private final class TransferSceneInteractorMock: TransferSceneInteractorInput {
    var isAllPayeeDownloaded:Bool = false
    func getAllPayee() {
       isAllPayeeDownloaded = true
    }
    
    var transferModel: TransferSceneModel?
    func transferTo(payee: TransferSceneModel) {
        self.transferModel = payee
    }
}

private final class TransferSceneRoutingMock: TransferSceneRouting{
    var popToPreviousCallback:Bool = false
    func popToPrevious() {
        popToPreviousCallback = true
    }
    
    func showFailure(message: String) {
        
    }
    
    func showSuccess(msg: String) {
        print("XXXXXSS")
    }
    
    func showPopOver(for indetifier: String, popoverList: [Payee], delegate: DropdownViewControllerDelegate) {
        
    }
}


private extension TransferSceneViewControllerTests{
    func create() -> (BindingTextField,BindingTextField,BindingTextField,BindingTextField,TransferSceneModel){
        let recipientTextField = BindingTextField()
        let dateOfTransferTextField = BindingTextField()
        let descTextField = BindingTextField()
        let amountTextField = BindingTextField()
        let tModel = TransferSceneModel()
        return (recipientTextField,dateOfTransferTextField,descTextField,amountTextField,tModel)
    }
}







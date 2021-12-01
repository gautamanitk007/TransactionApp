//
//  TransfeSceneInteractorTests.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import XCTest
@testable import TransactionApp

final class TransfeSceneInteractorTests: XCTestCase {
    private var sut: TransferSceneInteractor!
    private var presenter: TransferScenePresentationLogicMock!
   
    override func setUp() {
        super.setUp()
        sut = TransferSceneInteractor()
        presenter = TransferScenePresentationLogicMock()
        sut!.presenter = presenter
    }
    override func tearDown() {
        sut = nil
        presenter = nil
        TransactionManager.shared.totalBalance = 0
        TransactionManager.shared.enableMock = false
        super.tearDown()
    }

    func test_fund_transfer_empty_account(){
        //Given
        var model = TransferSceneDataModel.TransferSceneViewModel()
        model.recipientAccountNo = ""
        //When
        sut.transferTo(payee: model)
        //Then
        XCTAssertNotNil(self.presenter.errorMsg)
        XCTAssertEqual(presenter.errorMsg, Utils.getLocalisedValue(key: "Recipient_Key"))
    }
    func test_fund_transfer_empty_desc(){
        //Given
        var model = TransferSceneDataModel.TransferSceneViewModel()
        model.recipientAccountNo = "111"
        model.description = ""
        //When
        sut.transferTo(payee: model)
        //Then
        XCTAssertNotNil(presenter.errorMsg)
        XCTAssertEqual(presenter.errorMsg, Utils.getLocalisedValue(key: "Description_Key"))
    }
    
    func test_fund_transfer_empty_date(){
        //Given
        var model = TransferSceneDataModel.TransferSceneViewModel()
        model.recipientAccountNo = "111"
        model.description = "rental"
        model.date = ""
        //When
        sut.transferTo(payee: model)
        //Then
        XCTAssertNotNil(presenter.errorMsg)
        XCTAssertEqual(presenter.errorMsg, Utils.getLocalisedValue(key: "Date_Key"))
    }
    func test_fund_transfer_empty_amount(){
        //Given
        var model = TransferSceneDataModel.TransferSceneViewModel()
        model.recipientAccountNo = "111"
        model.description = "rental"
        model.date = Date().convertToString()
        model.amount = ""
        //When
        sut.transferTo(payee: model)
        //Then
        XCTAssertNotNil(presenter.errorMsg)
        XCTAssertEqual(presenter.errorMsg, Utils.getLocalisedValue(key: "Amount_Key"))
    }
    
    func test_fund_transfer_amount_overflow(){
        //Given
        var model = TransferSceneDataModel.TransferSceneViewModel()
        TransactionManager.shared.totalBalance = 500
        model.recipientAccountNo = "111"
        model.description = "rental"
        model.date = Date().convertToString()
        model.amount = "1000"
        //When
        sut.transferTo(payee: model)
        //Then
        XCTAssertTrue(presenter.errorCalled)
        XCTAssertEqual(presenter.errorMsg, Utils.getLocalisedValue(key: "Amount_Overflow"))
       
    }
    func test_fund_transfer_via_mock_api(){
        //Given
        let model = TransferSceneDataModel.TransferSceneViewModel(recipientAccountNo: "111", amount: "100",
                                       date: Date().convertToString(),
                                       description: "House Cleaning")
        TransactionManager.shared.totalBalance = 50000

        //When
        sut.transferTo(payee: model)
        
    }
    func test_fund_tansfer_on_real_server(){
        //Given
        let fundExp = self.expectation(description: "Fund transfer Expectation")
        TransactionManager.shared.totalBalance = 5000
        TransactionManager.shared.enableMock = false
    
        let transferModel = TransferSceneDataModel.TransferSceneViewModel(recipientAccountNo: "111", amount: "20", date: Date().convertToString(), description: "Pay to Rahul")
        //When
        sut.transferTo(payee: transferModel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let self = self else { return }
            fundExp.fulfill()
            //Then
            XCTAssertNotNil(self.presenter.tModel)
            XCTAssertFalse(self.presenter.errorCalled)
        }
        waitForExpectations(timeout: 2)
    }
}

private final class TransferScenePresentationLogicMock: TransferScenePresentationLogic{
    func showPayeeList(response: TransferSceneDataModel.PayeeResponse) { }
    var errorCalled:Bool = false
    var errorMsg:String? 
    func showErrorMessage(error: String?) {
        errorCalled = true
        errorMsg = error
    }
    var tModel:TransferSceneDataModel.TransferResponse?
    func transferSuccess(response: TransferSceneDataModel.TransferResponse) {
        tModel = response
    }
}

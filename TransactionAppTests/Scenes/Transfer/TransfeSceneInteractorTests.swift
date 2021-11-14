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
    private var presenter: TransferScenePresenterInputMock!
    private var service: APIServiceMock!
    override func setUp() {
        super.setUp()
        sut = TransferSceneInteractor()
        service = APIServiceMock()
        presenter = TransferScenePresenterInputMock()
        sut.presenter = presenter
        sut.service = service
    }
    override func tearDown() {
        sut = nil
        service = nil
        presenter = nil
        TransactionManager.shared.totalBalance = 0
        TransactionManager.shared.enableMock = false
        super.tearDown()
    }

    func test_payee(){
        //When
        sut.getAllPayee()
        //Then
        XCTAssertTrue(service.isPayeeCalled)
    }
    func test_fund_transfer_empty_account(){
        //Given
        var model = TransferSceneModel()
        model.recipientAccountNo = ""
        //When
        sut.transferTo(payee: model)
        //Then
        XCTAssertNotNil(presenter.errorMsg)
        XCTAssertEqual(presenter.errorMsg, Utils.getLocalisedValue(key: "Recipient_Key"))
    }
    func test_fund_transfer_empty_desc(){
        //Given
        var model = TransferSceneModel()
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
        var model = TransferSceneModel()
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
        var model = TransferSceneModel()
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
        var model = TransferSceneModel()
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
        let model = TransferSceneModel(recipientAccountNo: "111", amount: "100",
                                       date: Date().convertToString(),
                                       description: "House Cleaning")
        TransactionManager.shared.totalBalance = 50000

        //When
        sut.transferTo(payee: model)
        //Then
        XCTAssertNotNil(service.isFundTransferCalled)
    }
    func test_fund_tansfer_on_real_server(){
        //Given
        let fundExp = self.expectation(description: "Fund transfer Expectation")
        TransactionManager.shared.totalBalance = 5000
        TransactionManager.shared.enableMock = false
        sut.service = nil
        sut.service = APIService(APIManager())
        let transferModel = TransferSceneModel(recipientAccountNo: "111", amount: "20", date: Date().convertToString(), description: "Pay to Rahul")
        //When
        sut.transferTo(payee: transferModel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            fundExp.fulfill()
        }
        waitForExpectations(timeout: 1)
        //Then
        XCTAssertNil(presenter.tModel)
        XCTAssertTrue(presenter.errorCalled)
    }
}

private final class TransferScenePresenterInputMock: TransferScenePresenterInput {
    func showPayeeList(response: PayeeResponse) { }
    var errorCalled:Bool = false
    var errorMsg:String? 
    func showErrorMessage(error: String?) {
        errorCalled = true
        errorMsg = error
    }
    var tModel:TransferResponse?
    func transferSuccess(response: TransferResponse) {
        tModel = response
    }
}

private final class APIServiceMock: ServiceProtocol {
    var isFundTransferCalled:Bool = false
    func fundTransfer(params: [String : Any], on completion: @escaping (TransferResponse?, ApiError?) -> ()) {
        isFundTransferCalled = true
    }
    var isPayeeCalled:Bool = false
    func getAllPayee(on completion: @escaping (PayeeResponse?, ApiError?) -> ()) {
        self.isPayeeCalled = true
    }
}

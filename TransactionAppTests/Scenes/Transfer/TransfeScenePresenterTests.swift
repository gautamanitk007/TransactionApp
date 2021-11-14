//
//  TransfeScenePresenterTests.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import XCTest
@testable import TransactionApp

final class TransfeScenePresenterTests: XCTestCase {
    private var sut: TransferScenePresenter!
    private var vc: TransferScenePresenterOutputMock!
    
    override func setUp() {
        super.setUp()
        vc = TransferScenePresenterOutputMock()
        sut = TransferScenePresenter()
        sut.viewController = vc
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        super.tearDown()
    }
    func test_empty_payee_list(){
        //Given
        let bundle = Bundle(for: TransfeScenePresenterTests.self)
        guard let payeeReponse:PayeeResponse = Utils.load(bundle: bundle, fileName: "PayeeEmpty") else{
            XCTFail("Fail to load")
            return
        }
        //When
        sut.showPayeeList(response: payeeReponse)
        //Then
        XCTAssertEqual(vc.payeeError, Utils.getLocalisedValue(key:"Payee_Not_Exist"))
    }
    func test_payee_list(){
        //Given
        let bundle = Bundle(for: TransfeScenePresenterTests.self)
        guard let payeeReponse:PayeeResponse = Utils.load(bundle: bundle, fileName: "Payee") else{
            XCTFail("Fail to load")
            return
        }
        //When
        sut.showPayeeList(response: payeeReponse)
        //Then
        XCTAssertEqual(vc.payeeError, Utils.getLocalisedValue(key:"Payee_Not_Exist"))
    }
}

private final class TransferScenePresenterOutputMock: TransferScenePresenterOutput {
    
    func dispayPayee(payeeList: [Payee]) {
        
    }
    var payeeError:String = ""
    func displayError(_ error: String) {
        payeeError = error
    }
    
    func transferSuccess(msg: String) {
        
    }
}

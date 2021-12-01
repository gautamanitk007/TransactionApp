//
//  DashboardSceneInteractorTests.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import XCTest
@testable import TransactionApp


final class DashboardSceneInteractorTests: XCTestCase {
    private var sut: DashboardSceneInteractor!
    private var presenter: DashboardScenePresentationLogicMock!
    override func setUp() {
        super.setUp()
        sut = DashboardSceneInteractor()
        presenter = DashboardScenePresentationLogicMock()
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        //service = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_checkBalance_by_mock_data(){
        //Given
        TransactionManager.shared.enableMock = true
        let expection = self.expectation(description: "Balance fetching expection")
        //When
        sut.service.checkBalances(on: { (response, error) in
            expection.fulfill()
            TransactionManager.shared.enableMock = false
            //Then
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            XCTAssertEqual(Float(response!.balance!), 100000.0)
            
        })
        waitForExpectations(timeout: 1)
    }
    func test_checkBalance_from_server(){
        //Given
        let expection = self.expectation(description: "Balance fetching expection")
        //When
        //This API call always failed due to empty token
        sut.service.checkBalances(on: { (_, error) in
            expection.fulfill()
            //Then
            XCTAssertNotNil(error)
            XCTAssertNotNil(error?.message)
        })
        waitForExpectations(timeout: 1)
    }
    
    func test_allTransaction_by_mock_data(){
        //Given
        TransactionManager.shared.enableMock = true
        let expection = self.expectation(description: "Download all transaction expection")
        //When
        sut.service.getAllTransactions(on: { (response, error) in
            expection.fulfill()
            TransactionManager.shared.enableMock = false
            //Then
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            XCTAssertEqual(response?.data?.count, 5)
        })
        waitForExpectations(timeout: 1)
    }
    func test_allTransaction_from_server(){
        //Given
        let expection = self.expectation(description: "Download all transaction expection")
        //When
        //This API call always failed due to empty token
        sut.service.getAllTransactions(on: { (_, error) in
            expection.fulfill()
            //Then
            XCTAssertNotNil(error)
            XCTAssertNotNil(error?.message)
        })
        waitForExpectations(timeout: 1)
    }
    func test_balance_presenter_call(){
        //Given
        let bundle = Bundle(for: DashboardSceneInteractorTests.self)
        guard let balance:DashboardSceneDataModel.BalanceResponse = Utils.load(bundle: bundle, fileName: "Balance") else {
            XCTFail("Failed to load Balance.json")
            return
        }
        //When
        sut.presenter?.showBalance(response: balance)
        //Then
        XCTAssertEqual(presenter.amount, 100000.0)
    }
    
    func test_show_transaction_presenter_call(){
        //Given
        let bundle = Bundle(for: DashboardSceneInteractorTests.self)
        guard let tns:DashboardSceneDataModel.TransactionResponse = Utils.load(bundle: bundle, fileName: "Transactions") else {
            XCTFail("Failed to load Balance.json")
            return
        }
        //When
        sut.presenter?.showTransactions(response: tns)
        //Then
        XCTAssertEqual(presenter.transCount, 5)
    }
    
}

private final class DashboardScenePresentationLogicMock: DashboardScenePresentationLogic {
    
    var transCount: Int = 0
    func showTransactions(response: DashboardSceneDataModel.TransactionResponse){
        transCount = response.data!.count
    }
    
    var amount: Float = 0.0
    func showBalance(response: DashboardSceneDataModel.BalanceResponse) {
        amount = Float(response.balance!)
    }
    
    func didFailedToLoad(error: String?) {
    }
}

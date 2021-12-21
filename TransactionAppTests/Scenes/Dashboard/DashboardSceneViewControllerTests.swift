//
//  DashboardSceneViewControllerTests.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import XCTest
@testable import TransactionApp

final class DashboardSceneViewControllerTests: XCTestCase {
    private var sut: DashboardSceneViewController!
    private var interactor: DashboardSceneBussinessLogicMock!
    private var router: DashboardSceneRoutingLogicMock!
    override func setUp() {
        super.setUp()
        
        sut = DashboardSceneViewController()
        sut.loadView()
        interactor = DashboardSceneBussinessLogicMock()
        sut.interactor = interactor
        router = DashboardSceneRoutingLogicMock()
        sut.router = router
        TransactionManager.shared.enableMock = true
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        TransactionManager.shared.enableMock = false
        super.tearDown()
    }
    
    func test_logout_tapped(){
        //Given
        let btnSender = UIBarButtonItem()
        //When
        sut.logoutTapped(btnSender)
        //Then
        XCTAssertEqual(TransactionManager.shared.token, "")
        XCTAssertTrue(self.router.isPopViewControllerCalled)
    }
    
    func test_transfer_tapped(){
        // Given
        let btnTranser = sut.btnTransfer
        //When
        sut.didTransferTapped(btnTranser as Any)
        //Then
        XCTAssertTrue(self.router.isNextControolerCalled)
    }
    
    func test_refresh_page(){
        //When
        sut.refreshPage()
        //Then
        XCTAssertTrue(self.interactor.isCheckBalanceCalled)
        XCTAssertTrue(self.interactor.isGetAllTransactionCalled)
    }
    
    func test_viewDidLoad(){
        // Given
        let tableView = UITableView()
        let lblAmount = UILabel()
        sut.lblAmount = lblAmount
        sut.activityTable = tableView
        //When
        sut.viewDidLoad()
        //Then
        XCTAssertNotNil(sut.lblAmount)
        XCTAssertNotNil(sut.datasource)
        XCTAssertNotNil(sut.activityView)
    }
    
    func test_viewWillAppear(){
        //Given
        TransactionManager.shared.totalBalance = 100
        let lblAmount = UILabel()
        sut.lblAmount = lblAmount
        //When
        sut.viewWillAppear(true)
        //Then
        XCTAssertEqual(sut.lblAmount.text!, "S$100.0")
    }
    
}
private final class DashboardSceneBussinessLogicMock: DashboardSceneBussinessLogic {
    var isCheckBalanceCalled: Bool = false
    func checkBalance() {
        isCheckBalanceCalled = true
    }
    
    var isGetAllTransactionCalled: Bool = false
    func getAllTransactions() {
        isGetAllTransactionCalled = true
    }
}

private final class DashboardSceneRoutingLogicMock: DashboardSceneRoutingLogic{
    var isPopViewControllerCalled:Bool = false
    func popToRootController() {
        isPopViewControllerCalled = true
    }
    
    var isNextControolerCalled:Bool = false
    func showNextController() {
        isNextControolerCalled = true
    }
    var isError = false
    func showFailure(message: String) {
        self.isError = true
        XCTAssertEqual(message, "Failed to load")
    }
}




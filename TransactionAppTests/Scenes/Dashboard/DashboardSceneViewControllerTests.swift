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
    private var interactor: DashboardSceneInteractorMock!
    private var router: DashboardSceneRoutingMock!
    override func setUp() {
        super.setUp()
        
        sut = DashboardSceneViewController()
        sut.loadView()
        interactor = DashboardSceneInteractorMock()
        sut.interactor = interactor
        router = DashboardSceneRoutingMock()
        sut.router = router
        TransactionManager.shared.enableMock = true
        
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        super.tearDown()
    }
    
    func test_logout_tapped(){
        //Given
        let btnSender = UIBarButtonItem()
        //When
        sut.logoutTapped(btnSender)
        //Then
        XCTAssertTrue(self.router.isPopViewControllerCalled)
    }
}
private final class DashboardSceneInteractorMock: DashboardSceneInteractorInput {
    func checkBalance() {
        
    }
    
    func getAllTransactions() {
        
    }
}

private final class DashboardSceneRoutingMock: DashboardSceneRouting{
    var isPopViewControllerCalled:Bool = false
    func popToPrevious() {
        isPopViewControllerCalled = true
    }
    
    func showNextController() {
        
    }
    
    var loginSuccess = false
    var loginFailed = false
    func showSuccess() {
        self.loginSuccess = true
    }

    func showFailure(message: String) {
        self.loginFailed = true
        XCTAssertEqual(message, "Failed to load")
    }
}




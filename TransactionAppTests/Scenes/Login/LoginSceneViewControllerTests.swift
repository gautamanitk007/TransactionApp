//
//  LoginSceneViewControllerTests.swift
//  TransactionApp
//
//  Created by Gautam Singh on 7/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import XCTest
@testable import TransactionApp

final class LoginSceneViewControllerTests: XCTestCase {
    private var sut: LoginSceneViewController!
    private var interactor: LoginSceneInteractorMock!
    private var router: LoginSceneRoutingLogicMock!
    override func setUp() {
        super.setUp()
        
        sut = LoginSceneViewController()
        sut.userModel = UserModel()
        sut.loadView()
        interactor = LoginSceneInteractorMock()
        sut.interactor = interactor
        router = LoginSceneRoutingLogicMock()
        sut.router = router
        TransactionManager.shared.enableMock = true
        
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        super.tearDown()
    }
    
    func test_correct_credentials() {
        sut.userModel?.username = "ocbc"
        sut.userModel?.password = "123456"
        sut.didLoginTapped(UIButton() as Any)
    }
    
    func test_router_call_success() {
        sut.loginSuccess()
        XCTAssertTrue(router.loginSuccess)
    }
    
    func test_router_call_failed() {
        sut.loginFailed(message: "Failed to load")
        XCTAssertTrue(router.loginFailed)
    }
}
private final class LoginSceneInteractorMock: LoginSceneInteractorInput {
    func startLogin(user userModel: UserModel) {
        XCTAssertNotNil(userModel)
        XCTAssertEqual(userModel.username, "ocbc")
        XCTAssertEqual(userModel.password, "123456")
    }
}

private final class LoginSceneRoutingLogicMock: LoginSceneRoutingLogic {
    var loginSuccess = false
    var loginFailed = false
    func showLoginSuccess() {
        self.loginSuccess = true
    }

    func showLogingFailure(message: String) {
        self.loginFailed = true
        XCTAssertEqual(message, "Failed to load")
    }
}

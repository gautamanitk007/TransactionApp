//
//  LoginScenePresenterTests.swift
//  TransactionAppTests
//
//  Created by Gautam Singh on 12/11/21.
//

import XCTest
@testable import TransactionApp

final class LoginScenePresenterTests: XCTestCase {
    private var sut: LoginScenePresenter!
    private var vc: LoginScenePresenterOutputMock!
    
    override func setUp() {
        super.setUp()
        
        vc = LoginScenePresenterOutputMock()
        sut = LoginScenePresenter()
        sut.viewController = vc
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        
        super.tearDown()
    }
    
    func test_presenter_success() {
        sut.logingSuccess()
        XCTAssertTrue(vc.showLogingSuccessCalled)
    }
    
    func test_presenter_failed() {
        sut.logingFailed(message: "Failed")
        XCTAssertTrue(vc.showLogingFailureCalled.0)
    }
}

private final class LoginScenePresenterOutputMock: LoginScenePresenterOutput {
    var showLogingFailureCalled: (Bool, String)!
    var showLogingSuccessCalled: Bool = false
    func loginSuccess() {
        showLogingSuccessCalled = true
    }
    
    func loginFailed(message: String) {
        showLogingFailureCalled = (true, message)
    }
}

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
    private var vc: LoginSceneDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        sut = LoginScenePresenter()
        vc = LoginSceneDisplayLogicMock()
        sut.viewController = vc
    }
    
    override func tearDown() {
        sut = nil
        vc = nil
        
        super.tearDown()
    }
    
    func test_presenter_success() {
        
        guard let reposne: LoginSceneDataModel.Response = Utils.load(bundle: Bundle(for: APIService.self), fileName: "LoginResponse") else {
            XCTFail("Failed to load")
            return
        }
        sut.presentLogin(response: reposne)
        XCTAssertTrue(vc.showLogingSuccessCalled)
    }
    
    func test_presenter_failed() {
        sut.presentLogin(error: LoginSceneDataModel.Error(error: "Failed"))
        XCTAssertTrue(vc.showLogingFailureCalled.0)
    }
}

private final class LoginSceneDisplayLogicMock: LoginSceneDisplayLogic {
    
    var showLogingFailureCalled: (Bool, String)!
    var showLogingSuccessCalled: Bool = false
    
    func dispayLoginSuccess(viewModel: LoginSceneDataModel.ViewModel) {
        showLogingSuccessCalled = true
    }
    
    func displayLoginFailed(viewModel: LoginSceneDataModel.ViewModel) {
        showLogingFailureCalled = (true, viewModel.error!)
    }
}

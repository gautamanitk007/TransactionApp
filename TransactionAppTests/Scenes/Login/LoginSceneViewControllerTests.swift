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
    private var router: LoginSceneRoutingMock!
    override func setUp() {
        super.setUp()
        
        sut = LoginSceneViewController()
        sut.userModel = UserModel()
        sut.loadView()
        interactor = LoginSceneInteractorMock()
        sut.interactor = interactor
        router = LoginSceneRoutingMock()
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
        //Given
        sut.userModel?.username = "ocbc"
        sut.userModel?.password = "123456"
        
        //When
        sut.didLoginTapped(UIButton() as Any)
    }
    
    func test_router_call_success() {
        //When
        sut.loginSuccess()
        //Then
        XCTAssertTrue(router.loginSuccess)
    }
    
    func test_router_call_failed() {
        //When
        sut.loginFailed(message: "Failed to load")
        //Then
        XCTAssertTrue(router.loginFailed)
    }
    
    func test_viewDidLoad(){
        // Given
        let txtFieldUser = BindingTextField()
        let txtFieldPass = BindingTextField()
        let btnLogin = UIButton()
        sut.txtPassword = txtFieldPass
        sut.txtUsername = txtFieldUser
        sut.btnLogin = btnLogin
        //When
        sut.viewDidLoad()
        //Then
        XCTAssertEqual(sut.txtUsername.text, "")
        XCTAssertEqual(sut.txtPassword.text, "")
        XCTAssertEqual(sut.txtUsername.placeholder, Utils.getLocalisedValue(key: "Login_Text_Field_Placeholder"))
        XCTAssertEqual(sut.txtPassword.placeholder, Utils.getLocalisedValue(key: "Password_Text_Field_Placeholder"))
        
    }
}
private final class LoginSceneInteractorMock: LoginSceneInteractorInput {
    func startLogin(user userModel: UserModel) {
        XCTAssertNotNil(userModel)
        XCTAssertEqual(userModel.username, "ocbc")
        XCTAssertEqual(userModel.password, "123456")
    }
}

private final class LoginSceneRoutingMock: LoginSceneRouting{
    var loginSuccess = false
    var loginFailed = false
    func showLoginSuccess() {
        self.loginSuccess = true
    }

    func showFailure(message: String) {
        self.loginFailed = true
        XCTAssertEqual(message, "Failed to load")
    }
}

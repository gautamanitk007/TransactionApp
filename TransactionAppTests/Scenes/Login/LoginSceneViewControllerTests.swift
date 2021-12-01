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
    private var interactor: LoginSceneBusinessLogicMock!
    private var router: LoginSceneRoutingLogicMock!
    override func setUp() {
        super.setUp()
        
        sut = LoginSceneViewController()
        sut.userModel = LoginSceneDataModel.Request()
        sut.loadView()
        interactor = LoginSceneBusinessLogicMock()
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
        //Given
        sut.userModel?.username = "ocbc"
        sut.userModel?.password = "123456"
        
        //When
        sut.didLoginTapped(UIButton() as Any)
    }
    
    func test_router_call_success() {
        //When
        let viewModel = LoginSceneDataModel.ViewModel(message: "", token: "xxxxddd", error: nil)
        sut.dispayLoginSuccess(viewModel: viewModel)
        //Then
        XCTAssertTrue(router.readyToLoadDashboard)
    }
    
    func test_router_call_failed() {
        //When
        let errorMessage = "Login Failed"
        let viewModel = LoginSceneDataModel.ViewModel(message: "", token: "", error: errorMessage)
        sut.displayLoginFailed(viewModel: viewModel)
        //Then
        XCTAssertEqual(router.loginFailedMsg, errorMessage)
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
private final class LoginSceneBusinessLogicMock: LoginSceneBusinessLogic {
    func startLogin(request: LoginSceneDataModel.Request) {
        XCTAssertNotNil(request)
        XCTAssertEqual(request.username, "ocbc")
        XCTAssertEqual(request.password, "123456")
    }
}

private final class LoginSceneRoutingLogicMock: LoginSceneRoutingLogic{
    var readyToLoadDashboard = false
    var loginFailedMsg: String = ""
    func showDashboard() {
        self.readyToLoadDashboard = true
    }
    func showFailure(message: String) {
        self.loginFailedMsg = message
    }
}

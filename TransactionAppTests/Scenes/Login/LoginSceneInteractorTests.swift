//
//  LoginSceneInteractorTests.swift
//  TransactionAppTests
//
//  Created by Gautam Singh on 12/11/21.
//

import XCTest
@testable import TransactionApp

final class LoginSceneInteractorTests: XCTestCase  {
    private var sut: LoginSceneInteractor!
    private var service: APIServiceMock!
    private var presenter: LoginScenePresenterInputMock!
    override func setUp() {
        super.setUp()
        sut = LoginSceneInteractor()
        service = APIServiceMock()
        presenter = LoginScenePresenterInputMock()
        sut.presenter = presenter
        sut.service = service
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        presenter = nil
        TransactionManager.shared.apiError = ""
        super.tearDown()
    }
    func test_interactor_with_empty_username() {
        //Given
        let apiError = Utils.getLocalisedValue(key:"UserName_Empty")
        TransactionManager.shared.apiError = apiError
        let userModel = UserModel(username: "", password: "344")
        
        //When
        sut.startLogin(user: userModel)
        //Then
        XCTAssertTrue(presenter.interactorRespondedError)
    }
    func test_interactor_with_empty_passsword() {
        //Given
        let apiError = Utils.getLocalisedValue(key:"Password_Empty")
        TransactionManager.shared.apiError = apiError
        let userModel = UserModel(username: "123", password: "")
        //When
        sut.startLogin(user: userModel)
        XCTAssertTrue(presenter.interactorRespondedError)
    }
    
    func test_interactor_with_valid_credentials() {
        //Given
        let loginExp = self.expectation(description: "LoginApi Expectation")
        TransactionManager.shared.apiError = ""
        let userModel = UserModel(username: "ocbc", password: "123456")
        //When
        sut.startLogin(user: userModel)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            loginExp.fulfill()
        }
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(self.service.loginAPICall)
    }
}

private final class APIServiceMock: ServiceProtocol {
    var loginAPICall:Bool = false
    func startLogin(user userModel: UserModel, on completion: @escaping (LoginResponse?, ApiError?) -> ()) {
        self.loginAPICall = true
    }
}

private final class LoginScenePresenterInputMock: LoginScenePresenterInput {
    var interactorRespondedError: Bool = false
    var interactorRespondedSuccess: Bool = false
    func logingSuccess() {
        interactorRespondedSuccess = true
    }
    
    func logingFailed(message: String) {
        interactorRespondedError = true
        XCTAssertEqual(message, TransactionManager.shared.apiError)
    }
}
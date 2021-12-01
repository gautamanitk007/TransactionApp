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
    private var presenter: LoginScenePresentationLogicMock!
    override func setUp() {
        super.setUp()
        sut = LoginSceneInteractor()
        presenter = LoginScenePresentationLogicMock()
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    func test_interactor_with_empty_username() {
        //Given
        let userModel = LoginSceneDataModel.Request(username: "", password: "344")
        
        //When
        sut.startLogin(request: userModel)
        //Then
        XCTAssertEqual(presenter.errMsg, Utils.getLocalisedValue(key:"UserName_Empty"))
    }
    func test_interactor_with_empty_passsword() {
        //Given
        let userModel = LoginSceneDataModel.Request(username: "123", password: "")
        //When
        sut.startLogin(request: userModel)
        //Then
        XCTAssertEqual(presenter.errMsg, Utils.getLocalisedValue(key:"Password_Empty"))
    }
    
    func test_interactor_with_valid_credentials() {
        //Given
        let loginExp = self.expectation(description: "LoginApi Expectation")
        let userModel = LoginSceneDataModel.Request(username: "ocbc", password: "123456")
        //When
        sut.startLogin(request: userModel)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self = self else {return}
            loginExp.fulfill()
            XCTAssertTrue(self.presenter.interactorRespondedSuccess)
        }
        waitForExpectations(timeout: 2)
        
    }
}

private final class LoginScenePresentationLogicMock: LoginScenePresentationLogic {
    var errMsg: String = ""
    var interactorRespondedSuccess: Bool = false
    func presentLogin(response: LoginSceneDataModel.Response) {
        interactorRespondedSuccess = true
    }
    func presentLogin(error: LoginSceneDataModel.Error) {
        self.errMsg = error.error
    }
}

//
//  APIManagerTests.swift
//  TransactionAppTests
//
//  Created by Gautam Singh on 14/11/21.
//

import XCTest
@testable import TransactionApp

final class APIManagerTests: XCTestCase {
    var sut: APIManagerProtocol!
    override func setUp() {
        sut = APIManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func test_api_call_with_empty(){
        //Given
        let apiExpectation = self.expectation(description: "Api manager expectation")
        let userModel = LoginSceneDataModel.Request()
        let body = userModel.jsonValue()
        let request = APIRequest(endPoint: EndPoints.login.rawValue, postBody: body!)
        let loginResource = Resource<LoginSceneDataModel.Response>(request: request) { data in
            let loginResponse = try? JSONDecoder().decode(LoginSceneDataModel.Response.self, from: data)
            return loginResponse
        }
        //When
        sut.runAPI(resource: loginResource) { (response, error) in
            apiExpectation.fulfill()
            XCTAssertNotNil(error)
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func test_api_call_with_parameters(){
        //Given
        let apiExpectation = self.expectation(description: "Api manager expectation")
        let userModel = LoginSceneDataModel.Request(username: "ocbc", password: "123456")
        let body = userModel.jsonValue()
        let request = APIRequest(endPoint: EndPoints.login.rawValue, postBody: body!)
        let loginResource = Resource<LoginSceneDataModel.Response>(request: request) { data in
            let loginResponse = try? JSONDecoder().decode(LoginSceneDataModel.Response.self, from: data)
            return loginResponse
        }
        //When
        sut.runAPI(resource: loginResource) { (response, error) in
            apiExpectation.fulfill()
            XCTAssertNotNil(error)
        }
        waitForExpectations(timeout: 1.0)
    }
    
}

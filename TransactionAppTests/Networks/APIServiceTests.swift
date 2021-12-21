//
//  APIServiceTests.swift
//  TransactionAppTests
//
//  Created by Gautam Singh on 13/11/21.
//

import XCTest

@testable import TransactionApp


final class APIServiceTests: XCTestCase {
    var sut: ServiceProtocol!
    override func setUp() {
        sut = APIService(APIManager())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func test_interactor_with_empty_username() {
        //Given
        let loginExpectation = self.expectation(description: "Call Login API")
        let userModel = LoginSceneDataModel.Request(username: "", password: "344")

        //When
        sut.startLogin(request: userModel, on: { (response, error) in
            loginExpectation.fulfill()
            //Then
            if let resp = response, resp.status == ResponseValue.success.rawValue {
                XCTAssertNotNil(response?.token)
            } else{
                if error?.statusCode == ResponseCodes.server_notReachable.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerNotReachable"))
                } else if error?.statusCode == ResponseCodes.server_Not_Available.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerDown"))
                }else if error?.statusCode == ResponseCodes.notfound.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "NotFound"))
                } else{
                    XCTAssertEqual(response?.status, Utils.getLocalisedValue(key: "Failed"))
                    XCTAssertNil(response?.token)
                    XCTAssertNotNil(error)
                }
            }
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    func test_interactor_with_empty_passsword() {
        //Given
        let loginExpectation = self.expectation(description: "Call Login API")
        let userModel = LoginSceneDataModel.Request(username: "22", password: "")

        //When
        sut.startLogin(request: userModel, on: { (response, error) in
            loginExpectation.fulfill()
            //Then
            if let resp = response, resp.status == ResponseValue.success.rawValue {
                XCTAssertNotNil(response?.token)
            } else {
                if error?.statusCode == ResponseCodes.server_notReachable.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerNotReachable"))
                } else if error?.statusCode == ResponseCodes.server_Not_Available.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerDown"))
                }else if error?.statusCode == ResponseCodes.notfound.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "NotFound"))
                }else{
                    XCTAssertEqual(response?.status, Utils.getLocalisedValue(key: "Failed"))
                    XCTAssertNil(response?.token)
                    XCTAssertNotNil(error)
                }
            }
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func test_valid_credentials_value() {
        //Given
        let loginExpectation = self.expectation(description: "Call Login API")
        let userModel = LoginSceneDataModel.Request(username: "xxxxx", password: "yyyyy")

        //When
        sut.startLogin(request: userModel, on: { (response, error) in
            loginExpectation.fulfill()
            //Then
            if let resp = response, resp.status == ResponseValue.success.rawValue {
                XCTAssertNotNil(response?.token)
            } else {
                if error?.statusCode == ResponseCodes.server_notReachable.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerNotReachable"))
                } else if error?.statusCode == ResponseCodes.server_Not_Available.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerDown"))
                }else if error?.statusCode == ResponseCodes.notfound.rawValue{
                    XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "NotFound"))
                } else{
                    XCTAssertNotNil(error)
                    XCTAssertEqual(error!.message,Utils.getLocalisedValue(key: "ForBidden"))
                }
            }
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func test_validate_credentails_on_server(){
        //Given
        let loginExpectation = self.expectation(description: "Call Login API")
        let userModel = LoginSceneDataModel.Request(username: "ocbc", password: "123456")

        //When
        sut.startLogin(request: userModel, on: { (response, error) in
            loginExpectation.fulfill()
            //Then
            if response != nil {
                XCTAssertNotNil(response)
                XCTAssertNotNil(response?.token)
                XCTAssertEqual(response?.status, "success")
            }
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_check_balance(){
        //Given
        let loginExpectation = self.expectation(description: "Call Login API")
        let checkBalanceExp = self.expectation(description: "Check balance")
        let userModel = LoginSceneDataModel.Request(username: "ocbc", password: "123456")

        //When
        sut.startLogin(request: userModel, on: {[weak self] (response, error) in
            loginExpectation.fulfill()
            if error?.statusCode == ResponseCodes.server_notReachable.rawValue{
                checkBalanceExp.fulfill()
                XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerNotReachable"))
            }else if error?.statusCode == ResponseCodes.server_Not_Available.rawValue{
                checkBalanceExp.fulfill()
                XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerDown"))
            }else{
                if response != nil {
                    guard let self = self  else {return}
                    if let token = response?.token{
                        //Given
                        TransactionManager.shared.token = token
                    
                        //When
                        self.sut.checkBalances { (balResponse, bError) in
                            checkBalanceExp.fulfill()
                            TransactionManager.shared.token = ""
                            if balResponse != nil{
                                XCTAssertEqual(balResponse?.status, "success")
                            }
                        }
                    }
                } else {
                    checkBalanceExp.fulfill()
                    XCTAssertNotNil(error)
                    XCTAssertTrue(error!.message!.count > 0)
                }
            }
        })
        
        wait(for: [loginExpectation,checkBalanceExp], timeout: 3.0)
    }
    
    func test_all_transactions(){
        //Given
        let loginExpectation = self.expectation(description: "Call Login API")
        let transactionExp = self.expectation(description: "All transaction api call")
        let userModel = LoginSceneDataModel.Request(username: "ocbc", password: "123456")

        //When
        sut.startLogin(request: userModel, on: {[weak self] (response, error) in
            loginExpectation.fulfill()
            //Then
            if error?.statusCode == ResponseCodes.server_notReachable.rawValue{
                transactionExp.fulfill()
                XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerNotReachable"))
            }else if error?.statusCode == ResponseCodes.server_Not_Available.rawValue{
                transactionExp.fulfill()
                XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerDown"))
            }else{
                if response != nil {
                    guard let self = self  else {return}
                    if let token = response?.token{
                        //Given
                        TransactionManager.shared.token = token
                        //When
                        self.sut.getAllTransactions { (tResponse, tError) in
                            transactionExp.fulfill()
                            TransactionManager.shared.token = ""
                            if tResponse != nil{
                                XCTAssertEqual(tResponse?.status, "success")
                            }
                        }
                    }
                } else {
                    transactionExp.fulfill()
                    XCTAssertNotNil(error)
                    XCTAssertTrue(error!.message!.count > 0)
                }
            }
        })
        
        wait(for: [loginExpectation,transactionExp], timeout: 3.0)
    }
    
    func test_all_payee(){
        //Given
        let loginExpectation = self.expectation(description: "Call Login API")
        let payeeExp = self.expectation(description: "All payee api call")
        let userModel = LoginSceneDataModel.Request(username: "ocbc", password: "123456")

        //When
        sut.startLogin(request: userModel, on: {[weak self] (response, error) in
            loginExpectation.fulfill()
            //Then
            if error?.statusCode == ResponseCodes.server_notReachable.rawValue{
                payeeExp.fulfill()
                XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerNotReachable"))
            }else if error?.statusCode == ResponseCodes.server_Not_Available.rawValue{
                payeeExp.fulfill()
                XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerDown"))
            }else{
                if response != nil {
                    guard let self = self  else {return}
                    if let token = response?.token{
                        //Given
                        TransactionManager.shared.token = token
                        //When
                        self.sut.getAllPayee { (pResponse, pError) in
                            payeeExp.fulfill()
                            TransactionManager.shared.token = ""
                            if pResponse != nil{
                                XCTAssertEqual(pResponse?.status, "success")
                            }
                        }
                    }
                } else {
                    payeeExp.fulfill()
                    XCTAssertNotNil(error)
                    XCTAssertTrue(error!.message!.count > 0)
                }
            }
        })
        
        wait(for: [loginExpectation,payeeExp], timeout: 3.0)
    }
    func test_fund_transfer(){
        //Given
        let loginExpectation = self.expectation(description: "Call Login API")
        let transferExp = self.expectation(description: "transfer api call")
        let userModel = LoginSceneDataModel.Request(username: "ocbc", password: "123456")

        //When
        sut.startLogin(request: userModel, on: {[weak self] (response, error) in
            loginExpectation.fulfill()
            //Then
            if error?.statusCode == ResponseCodes.server_notReachable.rawValue{
                transferExp.fulfill()
                XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerNotReachable"))
            }else if error?.statusCode == ResponseCodes.server_Not_Available.rawValue{
                transferExp.fulfill()
                XCTAssertEqual(error?.message, Utils.getLocalisedValue(key: "ServerDown"))
            }else{
                if response != nil {
                    guard let self = self  else {return}
                    if let token = response?.token{
                        //Given
                        TransactionManager.shared.token = token
                        //When
                        let transferModel = TransferSceneDataModel.TransferSceneViewModel(recipientAccountNo: "4489-991-0023", amount: "500", date: Date().convertToString(), description: "xxxx")
                        
                        self.sut.fundTransfer(params: transferModel.jsonValue()!) { (ftResponse, ftError) in
                            transferExp.fulfill()
                            TransactionManager.shared.token = ""
                            if let resp = ftResponse, resp.status == ResponseValue.success.rawValue {
                                XCTAssertEqual(resp.data?.amount, transferModel.amount)
                                XCTAssertEqual(resp.data?.description, transferModel.description)
                                XCTAssertEqual(resp.data?.recipientAccountNo, transferModel.recipientAccountNo)
                            }else{
                                XCTAssertNotNil(ftError)
                            }
                        }
                    }
                } else {
                    transferExp.fulfill()
                    XCTAssertNotNil(error)
                    XCTAssertTrue(error!.message!.count > 0)
                }
            }
        })
        
        wait(for: [loginExpectation,transferExp], timeout: 3.0)
    }
    
}


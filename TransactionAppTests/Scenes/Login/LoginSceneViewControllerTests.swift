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

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginScene") as? LoginSceneViewController else {
            fatalError("Destination doesn't exist")
        }
        sut = destinationVC
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_login_tapped() {
        sut.didLoginTapped(sut.btnLogin as Any)
    }
}

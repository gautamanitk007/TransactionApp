//
//  DashboardSceneRouterTests.swift
//  TransactionApp
//
//  Created by Gautam Singh on 12/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import XCTest
@testable import TransactionApp


final class DashboardSceneRouterTests: XCTestCase {
  
 // private var router: DashboardSceneRouter!
  private var viewController: DashboardSceneViewControllerSpy!

  override func setUp() {
    viewController = DashboardSceneViewControllerSpy()
   // router = DashboardSceneRouter(viewController: viewController)
  }

  override func tearDown() {
    viewController = nil
   // router = nil
  }
}

// MARK: - Spy Classes Setup
private extension DashboardSceneRouterTests {

  final class DashboardSceneViewControllerSpy: UIViewController {
    var dismissExpectation: XCTestExpectation!
    var isDismissed: Bool = false

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
      isDismissed = true
      dismissExpectation.fulfill()
    }
  }
}

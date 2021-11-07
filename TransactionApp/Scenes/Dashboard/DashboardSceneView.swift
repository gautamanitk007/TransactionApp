//
//  DashboardSceneView.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol DashboardSceneViewDelegate where Self: UIViewController {
  
  func sendDataBackToParent(_ data: Data)
}

final class DashboardSceneView: UIView {
  
  weak var delegate: DashboardSceneViewDelegate?
  
  private enum ViewTrait {
    static let leftMargin: CGFloat = 10.0
  }
}

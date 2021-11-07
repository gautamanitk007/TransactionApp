//
//  TransferSceneView.swift
//  TransactionApp
//
//  Created by Gautam Singh on 6/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

protocol TransferSceneViewDelegate where Self: UIViewController {
  
  func sendDataBackToParent(_ data: Data)
}

final class TransferSceneView: UIView {
  
  weak var delegate: TransferSceneViewDelegate?
  
  private enum ViewTrait {
    static let leftMargin: CGFloat = 10.0
  }
}

//
//  DashboardViewController.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController {
  
  // MARK: Parameters
  
  private let viewModel: DashboardViewModel
  
  // MARK: Init
  
  init(viewModel: DashboardViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Dashboard"
    view.backgroundColor = .white
  }
  
}


//
//  DashboardCoordinator.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

// I'm using the coordinator just to inject dependencies (like a Builder)

final class DashboardCoordinator: Coordinator {
  let navigation: UINavigationController
  
  init(navigation: UINavigationController) {
    self.navigation = navigation
  }
  
  func start() {
    let viewModel = DashboardViewModel()
    let controller = DashboardViewController(viewModel: viewModel)
    
    navigation.pushViewController(controller, animated: true)
  }
}

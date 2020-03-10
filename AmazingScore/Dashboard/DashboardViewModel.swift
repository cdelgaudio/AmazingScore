//
//  DashboardViewModel.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class DashboardViewModel {
  
  private let network: Networking
  
  init(network: Networking) {
    self.network = network
  }
  
  func start() {
    network.getAccount { result in
      switch result {
      case .success(let response):
        print(response)
      case .failure(let error):
        print(error)
      }
    }
  }
}

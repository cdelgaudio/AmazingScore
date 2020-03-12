//
//  DashboardViewModel.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class DashboardViewModel {
  
  // MARK: Type
  
  struct CreditScoreModel {
    let score: Double
    let goal: Double
  }
  
  enum State {
    case failed, loading, loaded(CreditScoreModel)
  }
  
  // MARK: Parameters
  
  let state: ImmutableBinder<State>
  
  private let _state: Binder<State>
  
  private let network: Networking
  
  // MARK: Init
  
  init(network: Networking) {
    self.network = network
    _state = Binder(value: .failed)
    state = ImmutableBinder(_state)
  }
  
  // MARK: Methods
  
  func start() {
    _state.value = .loading
    network.getAccount { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        let creditScore = CreditScoreModel(
          score: Double(response.creditReportInfo.score),
          goal: Double(response.creditReportInfo.maxScoreValue)
        )
        self._state.value = .loaded(creditScore)
      case .failure:
        // I'm not going to handle different kind of error for this demo
        self._state.value = .failed
      }
    }
  }
}

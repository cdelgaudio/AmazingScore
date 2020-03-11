//
//  DashboardViewModel.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class DashboardViewModel {
  
  struct CreditScorePresenter {
    let title: String
    let score: Double
    let goal: Double
    let subtitle: String
    
    init(account: AccountResponse) {
      title = "Your credit score is"
      score = Double(account.creditReportInfo.score)
      goal = Double(account.creditReportInfo.maxScoreValue)
      subtitle = "out of \(account.creditReportInfo.maxScoreValue)"
    }
    
    init() {
      title = "Loading"
      score = 0
      goal = 1
      subtitle = "--"
    }
  }
  
  enum State {
    case failed, loading(CreditScorePresenter), loaded(CreditScorePresenter)
  }
  
  let state: Binder<State>
  
  private let network: Networking
  
  init(network: Networking) {
    self.network = network
    state = Binder(value: .failed)
  }
  
  func start() {
    state.value = .loading(.init())
    network.getAccount { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        self.state.value = .loaded(.init(account: response))
      case .failure:
        // I'm not going to handle different kind of error for this demo
        self.state.value = .failed
      }
    }
  }
}

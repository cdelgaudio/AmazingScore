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
  
  private let state: Binder<State>
  
  private let network: Networking
  
  // MARK: Init
  
  init(network: Networking, viewState: Binder<DashboardViewState>) {
    self.network = network
    state = Binder(value: .failed)
    Presenter.format(state: state, viewState: viewState)
  }
  
  // MARK: Methods
  
  func start() {
    state.value = .loading
    network.getAccount { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let response):
        let creditScore = CreditScoreModel(
          score: Double(response.creditReportInfo.score),
          goal: Double(response.creditReportInfo.maxScoreValue)
        )
        self.state.value = .loaded(creditScore)
      case .failure:
        // I'm not going to handle different kind of error for this demo
        self.state.value = .failed
      }
    }
  }
}

extension DashboardViewModel {
  enum Presenter {
    static func format(
      state: Binder<State>,
      viewState: Binder<DashboardViewState>
    ) {
      state.bind { state in
        switch state {
        case .failed:
          viewState.value = .failed(errorMessage: "Generic error")
        case .loading:
          viewState.value = .loading(scoreState: .init(
            title: "Loading",
            score: 0,
            progress: 0,
            subtitle: "..."
            )
          )
        case .loaded(let creditScore):
          viewState.value = .loaded(scoreState: .init(
            title: "Your credit score is",
            score: creditScore.score,
            progress: creditScore.score / creditScore.goal,
            subtitle: String(format: "out of %.0f", creditScore.goal)
            )
          )
        }
      }
    }
  }
}

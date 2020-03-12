//
//  DashboardPresenter.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 12/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class DashboardPresenter {
  func format(
    state: DashboardViewModel.State
  ) -> DashboardViewController.ViewState {
    switch state {
    case .failed:
      return .failed(errorMessage: "Generic error")
    case .loading:
      return .loading(scoreState: .init(
        title: "Loading",
        score: 0,
        progress: 0,
        subtitle: "..."
        )
      )
    case .loaded(let creditScore):
      return .loaded(scoreState: .init(
        title: "Your credit score is",
        score: creditScore.score,
        progress: creditScore.score / creditScore.goal,
        subtitle: String(format: "out of %.0f", creditScore.goal)
        )
      )
    }
  }
}

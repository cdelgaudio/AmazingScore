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
  
  // MARK: Views
  
  private let creditScoreView = CreditScoreView()
  
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
    
    setupView()
    setupBindings()
  }
  
  // MARK: ViewSetup
  
  private func setupView() {
    title = "Dashboard"
    view.backgroundColor = .white
    
    view.addSubview(creditScoreView)
    creditScoreView.autoCenterToSuperview()
    creditScoreView.autoPinToSuperview(edges: [.left(margin: 20)])
    creditScoreView.autoPintRatio()
  }
  
  // MARK: Bindings

  private func setupBindings() {
    viewModel.state.bind(on: .main) { [weak self] state in
      guard let self = self else { return }
      self.creditScoreView.isHidden = false
      switch state {
      case .loaded(let creditScore):
        self.creditScoreView.update(
          title: creditScore.title,
          value: creditScore.score,
          goal: creditScore.goal,
          subtitle: creditScore.subtitle,
          duration: 1)
      case .failed:
        self.creditScoreView.isHidden = true
        let errorAlert = self.makeErrorAlert(message: "generic error")
        self.present(errorAlert, animated: true)
      case .loading(let creditScore):
        self.creditScoreView.update(
        title: creditScore.title,
        value: creditScore.score,
        goal: creditScore.goal,
        subtitle: creditScore.subtitle,
        duration: 1)
      }
    }
    viewModel.start()
  }
  
  // MARK: Alert
  
  // I prefer to handle the alert inside the ViewController
  private func makeErrorAlert(message: String) -> UIAlertController {
    let alert = UIAlertController(
      title: "Error!",
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(
      .init(title: "Retry", style: .default, handler: { [weak self] _ in
        self?.viewModel.start()
      })
    )
    return alert
  }
}


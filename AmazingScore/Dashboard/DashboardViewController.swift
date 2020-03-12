//
//  DashboardViewController.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController {
  
  // MARK: Types
  
  enum ViewState {
    case failed(errorMessage: String)
    case loading(scoreState: CreditScoreView.ViewState)
    case loaded(scoreState: CreditScoreView.ViewState)
  }
  
  // MARK: Parameters
  
  private let viewModel: DashboardViewModel
  
  private let presenter: DashboardPresenter
  
  // MARK: Views
  
  private let creditScoreView = CreditScoreView()
  
  // MARK: Init
  
  init(viewModel: DashboardViewModel, presenter: DashboardPresenter) {
    self.viewModel = viewModel
    self.presenter = presenter
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
    viewModel.start()
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
      let viewState = self.presenter.format(state: state)
      self.creditScoreView.isHidden = false
      switch viewState {
      case .failed(let errorMessage):
        self.creditScoreView.isHidden = true
        let errorAlert = self.makeErrorAlert(message: errorMessage)
        self.present(errorAlert, animated: true)
      case .loading(let scoreState):
        self.creditScoreView.update(viewState: scoreState, duration: 1)
      case .loaded(let scoreState):
        self.creditScoreView.update(viewState: scoreState, duration: 1)
      }

    }
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


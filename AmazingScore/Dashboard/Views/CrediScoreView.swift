//
//  CrediScoreView.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class CreditScoreView: UIView {
  
  // MARK: Parameters

  private let color: UIColor = .red
  
  // MARK: Views

  private lazy var circularProgressView: CircularProgressView = {
    let progressView = CircularProgressView(
      frame: self.bounds,
      lineWidth: 5,
      lineColor: color,
      lineBackgroundColor: .clear
    )
    addSubview(progressView)
    return progressView
  }()
  
  private lazy var scoreLabel: AnimatedCounterLabel = AnimatedCounterLabel()
  
  private let titleLabel: UILabel = .titleLabel
  private let subtitleLabel: UILabel = .subtitleLabel
  
  // MARK: Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    scoreLabel.font = .helveticaNeueUltraLight
    scoreLabel.size(100)
    scoreLabel.textColor = color
    
    let stack = UIStackView(arrangedSubviews: [
      titleLabel,
      scoreLabel,
      subtitleLabel
    ])
    stack.axis = .vertical
    stack.alignment = .center
    stack.spacing = 10
    
    addSubview(stack)
    stack.autoCenterToSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Methods
  
  func update(
    title: String,
    value: Double,
    goal: Double,
    subtitle: String,
    duration: TimeInterval
  ) {
    guard goal != 0 else { return }
    circularProgressView.setProgress(value: value / goal, duration: duration)
    titleLabel.text = title
    subtitleLabel.text = subtitle
    scoreLabel.count(to: value, duration: duration)
  }
  
}

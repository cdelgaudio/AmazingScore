//
//  AnimatedCounterLabel.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class AnimatedCounterLabel: UILabel {
  
  // MARK: Parameters

  typealias Callback = () -> Void
  
  private var completion: Callback?
  
  private var startingValue: Double = 0
  private var destinationValue: Double = 0
  private var currentTime: TimeInterval = 0
  private var lastUpdate: TimeInterval = 0
  private var totalTime: TimeInterval = 0
  private var timer: CADisplayLink?
  private var decimals: Int = 0
  
  // MARK: Methods

  func count(
    to: Double,
    from: Double? = nil,
    decimalsToDisplay decimals: Int = 0,
    duration: TimeInterval = 0,
    completion: Callback? = nil
  ) {
    startingValue = from ?? destinationValue
    destinationValue = to
    self.decimals = decimals
    timer?.invalidate()
    timer = nil

    guard duration > 0 else {
      updateText(value: destinationValue)
      completion?()
      return
    }

    currentTime = 0.0
    totalTime = duration
    lastUpdate = Date.timeIntervalSinceReferenceDate

    timer = CADisplayLink(target: self, selector: #selector(self.update))
    timer?.add(to: .main, forMode: .default)
  }
  
  @objc private func update(timer: Timer) {
    let now: TimeInterval = Date.timeIntervalSinceReferenceDate
    currentTime += now - lastUpdate
    lastUpdate = now

    if currentTime >= totalTime {
      self.timer?.invalidate()
      self.timer = nil
      currentTime = totalTime
    }

    let progress = currentTime / totalTime
    let currentValue = currentTime >= totalTime
      ? destinationValue
      : startingValue + (progress * (destinationValue - startingValue))
    
    updateText(value: currentValue)
    if currentTime == totalTime { completion?() }
  }

  private func updateText(value: Double) {
    text = String(format: "%.\(decimals)f", value)
  }
}

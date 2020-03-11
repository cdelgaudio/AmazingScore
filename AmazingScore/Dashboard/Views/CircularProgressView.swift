//
//  CircularProgressView.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

final class CircularProgressView: UIView {
  
  // MARK: Parameters
  
  private let lineWidth: CGFloat
  
  private var progress: CGFloat
  
  private var oldValue: CGFloat
  
  // MARK: Views
  
  private lazy var backgroundCircularLayer: CAShapeLayer = makeCircularLayer(
    path: makePath()
  )
  
  private lazy var circularLayer: CAShapeLayer = makeCircularLayer(
    path: makePath()
  )
  
  private var gradientLayer = CAGradientLayer()
  
  // MARK: Init
  
  init(
    frame: CGRect = .zero,
    lineWidth: CGFloat = 5,
    lineColor: UIColor = .green,
    lineBackgroundColor: UIColor = .lightGray
  ) {
    self.lineWidth = lineWidth
    self.progress = 0
    self.oldValue = 0
    super.init(frame: frame)
    
    backgroundCircularLayer.strokeColor = lineBackgroundColor.cgColor
    backgroundCircularLayer.lineWidth = lineWidth * 0.8
    layer.addSublayer(backgroundCircularLayer)
    
    circularLayer.strokeColor = lineColor.cgColor
//    circularLayer.lineCap = .round
    circularLayer.strokeEnd = progress
    gradientLayer = makeGradientLayer(layer: circularLayer)
    layer.addSublayer(gradientLayer)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: LifeCycle
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    guard circularLayer.bounds != bounds else {return}
    
    [backgroundCircularLayer, circularLayer].forEach {
      $0.bounds = bounds
      $0.position = center
    }
    backgroundCircularLayer.path = makePath()
    circularLayer.path = makePath()
  }
  
  // MARK: Methods
  
  func setProgress(value: Double, duration: TimeInterval = 0) {
    oldValue = progress
    progress = CGFloat(value)
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.duration = duration
    animation.fillMode = .forwards
    animation.isRemovedOnCompletion = false
    animation.fromValue = oldValue
    animation.toValue = progress
    circularLayer.add(animation, forKey: "Load")
  }
  
  private func getAngle(value: CGFloat) -> CGFloat {
    let offset: CGFloat = -.pi / 2
    return value * 2 * .pi + offset
  }
  
  private func rotateLayer(animatedLayer: CALayer, duration: TimeInterval = 0) {
    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
    animation.duration = duration
    animation.fillMode = .forwards
    animation.isRemovedOnCompletion = false
    animation.fromValue = getAngle(value: oldValue)
    animation.toValue = getAngle(value: progress)
    animatedLayer.add(animation, forKey: "Rotate")
    
  }
  
  private func makeCircularLayer(path: CGPath) -> CAShapeLayer {
    let circularLayer = CAShapeLayer()
    circularLayer.path = path
    circularLayer.fillColor = UIColor.clear.cgColor
    circularLayer.lineWidth = lineWidth
    return circularLayer
  }
  
  private func makePath(
    startAngle: CGFloat = 0,
    endAngle: CGFloat = 1
  ) -> CGPath {
    UIBezierPath(
      arcCenter: center,
      radius: (min(bounds.height, bounds.width) - lineWidth) / 2,
      startAngle: getAngle(value: startAngle),
      endAngle: getAngle(value: endAngle),
      clockwise: true
    ).cgPath
  }
  
  private func makeGradientLayer(layer: CAShapeLayer) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.type = .conic
    gradientLayer.startPoint = .init(x: 0.5, y: 0.5)
    gradientLayer.endPoint = .init(x: 0.5, y: 0)
    let colors: [CGColor] = [layer.strokeColor?.darker(0.3), layer.strokeColor]
      .compactMap { $0 }
    gradientLayer.colors = colors
    gradientLayer.frame = bounds
    gradientLayer.mask = layer
    return gradientLayer
  }
  
}

// MARK: CGColor

private extension CGColor {
  func darker(_ percentage: CGFloat) -> CGColor? {
    guard let components = components else {
      return nil
    }
    let darkerComponents = components.map { $0 * percentage  }
    return CGColor(
      srgbRed: darkerComponents[0],
      green: darkerComponents[1],
      blue: darkerComponents[2],
      alpha: components[3]
    )
  }
}

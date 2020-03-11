//
//  UILabelExtension.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 11/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

extension UILabel {
  
  func size(_ fontSize: CGFloat) {
    font = font.withSize(fontSize)
  }
  
  static var titleLabel: UILabel {
    let label = UILabel()
    label.font = .helveticaNeue
    label.size(25)
    return label
  }
  
  static var subtitleLabel: UILabel {
    let label = UILabel()
    label.font = .helveticaNeue
    label.size(20)
    return label
  }
  
  static var bigTitleLabel: UILabel {
    let label = UILabel()
    label.font = .helveticaNeue
    label.size(100)
    return label
  }
}



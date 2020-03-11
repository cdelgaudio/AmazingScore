//
//  Binder.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// I create this simple class to connect the viewModel with the view without using an external library like RX
// Obviously it is just for demo purpose

// A better solution could be to use Combine, but it works only on iOS 13

final class Binder<T> {
  typealias Callback = ((T) -> Void)
  
  var value: T {
    didSet {
        callBack?(value)
    }
  }
  
  private var callBack: Callback?
  
  init(value: T) {
    self.value = value
  }
  
  func bind(on queue: DispatchQueue? = nil, callBack: @escaping Callback) {
    guard let queue = queue else {
      self.callBack = callBack
      return
    }
    self.callBack = { value in
      queue.async {
        callBack(value)
      }
    }
  }
}


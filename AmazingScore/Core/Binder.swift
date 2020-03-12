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


protocol Bindable {
  
  associatedtype T
  typealias Callback<T> = ((T) -> Void)
  
  func bind(on queue: DispatchQueue?, callBack: @escaping Callback<T>)
}

protocol MutableProperty {
  associatedtype T
  var value: T { get set }
}

extension Bindable {
    func bind(
    on queue: DispatchQueue? = nil,
    callBack: @escaping Callback<T>
  ) {
    bind(on: queue, callBack: callBack)
  }
}

final class Binder<T>: Bindable, MutableProperty {
  
  var value: T {
    didSet {
        callBack?(value)
    }
  }
  
  private var callBack: Callback<T>?
  
  init(value: T) {
    self.value = value
  }
  
  func bind(on queue: DispatchQueue? = nil, callBack: @escaping Callback<T>) {
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

protocol ImmutableProperty {
  associatedtype T
  var value: T { get }
}

final class ImmutableBinder<T>: Bindable, ImmutableProperty {
  
  var value: T { binder.value }
  
  private let binder: Binder<T>
  
  init(_ binder: Binder<T>) {
    self.binder = binder
  }
  
  func bind(on queue: DispatchQueue? = nil, callBack: @escaping Callback<T>) {
    binder.bind(on: queue, callBack: callBack)
  }
}

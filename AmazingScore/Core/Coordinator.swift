//
//  Coordinator.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// I'm not going to handle the back button and the children just because for this demo in not necessary
protocol Coordinator: AnyObject {
  func start()
}

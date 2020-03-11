//
//  NetworkMock.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 11/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

final class MockNetwork {
  
  enum TestCase {
    case failure, loading, loaded(AccountResponse)
  }
  
  private let testCase: TestCase
  
  init(_ testCase: TestCase) {
    self.testCase = testCase
  }
}

extension MockNetwork: Networking {
  
  func getAccount(completion: @escaping (NetworkResult<AccountResponse>) -> Void) {
    switch testCase {
    case .failure:
      completion(.failure(.network(description: "TestError")))
    case .loading:
      break
    case .loaded(let account):
      completion(.success(account))
    }
  }
  
}

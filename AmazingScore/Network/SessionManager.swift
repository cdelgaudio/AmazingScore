//
//  NetworkManager.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// I know this is not scalable but it is just a demo I don't want overkill it

typealias NetworkResult<D: Decodable> = Result<D, NetworkError>

protocol Networking: AnyObject {
  func getAccount(completion: @escaping (NetworkResult<AccountResponse>) -> Void)
}

enum NetworkError: Error {
  case parsing(description: String)
  case network(description: String)
  case request
}

// MARK: - NetworkManager

// I used the singleton pattern to easily inject it
final class SessionManager {
  
  static let shared = SessionManager()
  
  private let session: URLSession
  
  private init(session: URLSession = URLSession(configuration: .default)) {
    self.session = session
  }
  
  @discardableResult
  private func get<D: Decodable>(
    url: URL?,
    completion: @escaping (NetworkResult<D>) -> Void
  ) -> URLSessionDataTask? {
    guard let url = url else {
      completion(.failure(.request))
      return nil
    }
    
    let task = session.codableTask(with: url, completionHandler: completion)
    task.resume()
    return task
  }
}

// MARK: Networking

extension SessionManager: Networking {
  func getAccount(completion: @escaping (NetworkResult<AccountResponse>) -> Void) {
    get(url: NetworkRequest.account.url, completion: completion)
  }
}

// MARK: - URLSession

private extension URLSession {
  
  func codableTask<D: Decodable>(
    with url: URL,
    completionHandler: @escaping (NetworkResult<D>) -> Void
  ) -> URLSessionDataTask {
    self.dataTask(with: url) { data, response, error in
      guard let data = data else {
        let errorDescription = error?.localizedDescription ?? "No Data"
        completionHandler(.failure(.network(description: errorDescription)))
        return
      }
      do {
        completionHandler(.success(try JSONDecoder().decode(D.self, from: data)))
      } catch {
        let error = NetworkError.parsing(description: error.localizedDescription)
        completionHandler(.failure(error))
      }
    }
  }
}

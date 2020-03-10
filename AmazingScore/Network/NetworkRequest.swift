//
//  NetworkRequest.swift
//  AmazingScore
//
//  Created by Carmine Del Gaudio on 10/03/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import Foundation

// I know this is not scalable but it is just a demo I don't want overkill it
enum NetworkRequest {
  case account
  
  var url: URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "5lfoiyb0b3.execute-api.us-west-2.amazonaws.com"
    urlComponents.path = "/prod/mockcredit/values"
    return urlComponents.url
  }
}

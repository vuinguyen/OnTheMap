//
//  UdacityResponse.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/28/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import Foundation

struct UdacityResponse: Codable {
  let statusCode: Int
  let statusMessage: String

  enum CodingKeys: String, CodingKey {
    case statusCode = "status"
    case statusMessage = "error"
  }
}

extension UdacityResponse: LocalizedError {
  var debugDescription: String? {
    return statusMessage
  }
}

//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/28/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import Foundation

struct UserLogin: Codable {
  let username: String
  let password: String

  enum CodingKeys: String, CodingKey {
    case username
    case password
  }
}

struct LoginRequest: Codable {
  let udacity: UserLogin

  enum CodingKeys: String, CodingKey {
    case udacity
  }
}

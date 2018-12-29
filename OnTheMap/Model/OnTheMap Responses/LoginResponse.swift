//
//  LoginResponse.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/28/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import Foundation

struct Session: Codable {
  let id: String
  let expiration: String

  enum CodingKeys: String, CodingKey {
    case id
    case expiration
  }
}

struct Account: Codable {
  let key: String
  let registered: Bool

  enum CodingKeys: String, CodingKey {
    case key
    case registered
  }
}

struct LoginResponse: Codable {
  let session: Session
  let account: Account

  enum CodingKeys: String, CodingKey {
    case session
    case account
  }
}

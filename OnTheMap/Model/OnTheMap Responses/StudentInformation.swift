//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/29/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
  let objectId: String
  let uniqueKey: String?
  let firstName: String?
  let lastName: String?
  let mapString: String?
  let mediaURL: String?
  let latitude: Float?
  let longitude: Float?
  let createdAt: String
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case objectId
    case uniqueKey
    case firstName
    case lastName
    case mapString
    case mediaURL
    case latitude
    case longitude
    case createdAt
    case updatedAt
  }
}

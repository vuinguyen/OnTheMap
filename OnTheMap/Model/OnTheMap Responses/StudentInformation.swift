//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/29/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
  let objectId: String?
  let uniqueKey: String?
  let firstName: String?
  let lastName: String?
  let mapString: String?
  let mediaURL: String?
  let latitude: Double?
  let longitude: Double?
  let createdAt: String?
  let updatedAt: String?

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


  init(dictionary: [CodingKeys: Any]) {
    objectId = dictionary[CodingKeys.objectId] as? String
    uniqueKey = dictionary[CodingKeys.uniqueKey] as? String
    firstName = dictionary[CodingKeys.firstName] as? String
    lastName = dictionary[CodingKeys.lastName] as? String
    mapString = dictionary[CodingKeys.mapString] as? String
    mediaURL = dictionary[CodingKeys.mediaURL] as? String
    latitude = dictionary[CodingKeys.latitude] as? Double
    longitude = dictionary[CodingKeys.longitude] as? Double
    createdAt = dictionary[CodingKeys.createdAt] as? String
    updatedAt = dictionary[CodingKeys.updatedAt] as? String
  }
 
}

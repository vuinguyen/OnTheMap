//
//  StudentResults.swift
//  OnTheMap
//
//  Created by Vui Nguyen on 12/29/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import Foundation

struct StudentResults: Codable {
  let results: [StudentInformation]

  enum CodingKeys: String, CodingKey {
    case results
  }
}

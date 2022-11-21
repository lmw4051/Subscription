//
//  BuildConfiguration.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import Foundation

class BuildConfiguration {
  static let shared = BuildConfiguration()
  
  var apiUrl: String {
    return "https://noted-prod.herokuapp.com/api/"
  }
}

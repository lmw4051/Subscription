//
//  RequestError.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

enum RequestError: Error {
  case decode
  case invalidURL
  case noResponse
  case unauthorized
  case unexpectedStatusCode
  case wrongInfo
  case unknown
  
  var customMessage: String {
    switch self {
    case .decode:
      return "Decode error"
    case .unauthorized:
      return "Session expired"
    case .wrongInfo:
      return "Server error, please check the information and try again."
    default:
      return "Server error, please try again later."
    }
  }
}

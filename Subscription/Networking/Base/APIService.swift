//
//  APIService.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import Foundation

struct DummyBody: Encodable {}

struct APIService {
  static func encodeParam(key: String, value: String) -> String {
    var charSet = CharacterSet.urlQueryAllowed
    charSet.remove("+")
    return key.addingPercentEncoding(withAllowedCharacters: charSet)! +
    "=" +
    value.addingPercentEncoding(withAllowedCharacters: charSet)!
  }
  
  static func encodeUrl(string: String, query: [String: Any?]?) -> URL? {
    guard let url = URL(string: string) else {
      return nil
    }
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      return nil
    }
    
    var queryItems: [String] = []
    
    for (key, value) in query ?? [:] {
      if let str = value as? String {
        if !str.isEmpty {
          queryItems.append(APIService.encodeParam(key: key, value: str))
        }
      }
      if let strArray = value as? [String] {
        for str in strArray where !str.isEmpty {
          queryItems.append(APIService.encodeParam(key: key, value: str))
        }
      }
    }
    
    if queryItems.count == 0 {
      return url
    }
    urlComponents.percentEncodedQuery = queryItems.joined(separator: "&")
    return urlComponents.url
  }
  
  static func sendRequest<Response: Decodable>(
    path: String,
    method: RequestMethod = .get,
    query: [String: Any?]? = [:]
  ) async -> Result<Response, RequestError> {
    return await APIService.sendRequest(path: path, method: method, body: nil as DummyBody?, query: query)
  }
  
  static func sendRequest<Body: Encodable, Response: Decodable>(
    path: String,
    method: RequestMethod = .get,
    body: Body?,
    query: [String: Any?]? = [:]
  ) async -> Result<Response, RequestError> {
    let baseUrl = BuildConfiguration.shared.apiUrl
    guard let fullUrl = APIService.encodeUrl(string: baseUrl + path, query: query) else {
      return .failure(.invalidURL)
    }
    
    print("fullUrl: \(fullUrl)")
    
    var request = URLRequest(url: fullUrl)
    request.httpMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      if let bodyStruct = body {
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(bodyStruct)
      }
      
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let response = response as? HTTPURLResponse else {
        return .failure(.noResponse)
      }
      print("Response: ", String(data: data, encoding: .utf8)!)
      
      switch response.statusCode {
      case 200...299:
        do {
          let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
          return .success(decodedResponse)
        } catch {
          return .failure(.decode)
        }
      case 400:
        return .failure(.wrongInfo)
      case 401:
        return .failure(.unauthorized)
      default:
        return .failure(.unexpectedStatusCode)
      }
    } catch {
      return .failure(.unknown)
    }
  }
}

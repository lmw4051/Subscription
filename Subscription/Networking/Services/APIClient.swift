//
//  APIClient.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import Foundation
import ComposableArchitecture

struct APIClient {}

func apiTaskResult<T>(
  _ work: @escaping () async -> Result<T, RequestError>
) async -> TaskResult<T> {
  return await TaskResult { try (await work()).get() }
}

private enum APIClientKey: DependencyKey {
  static let liveValue = APIClient.live
}
extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClientKey.self] }
    set { self[APIClientKey.self] = newValue }
  }
}

extension APIClient {
  func verifyReceipt(
    _ body: VerifyReceiptPostRequestBody
  ) async -> TaskResult<VerifyReceipt> {
    return await apiTaskResult {
      await APIService.sendRequest(
        path: "verifyReceipt",
        method: .post,
        body: body
      )
    }
  }
  
  static let live = APIClient()
}

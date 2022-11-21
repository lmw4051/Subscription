//
//  VerifyReceipt.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import Foundation

struct VerifyReceipt: Decodable, Equatable {
  var status: Int = 0
  var environment: String = ""
  var hasFreeTrial: Bool = false
  var valid: Bool = false
}

struct VerifyReceiptPostRequestBody: Codable, Equatable {
  enum CodingKeys: String, CodingKey {
    case originalTransactionId = "original_transaction_id"
  }
  
  var originalTransactionId: String = ""
    
  init(originalTransactionId: String = "") {
    self.originalTransactionId = originalTransactionId
  }
}

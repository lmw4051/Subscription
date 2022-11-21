//
//  SubscriptionTests.swift
//  SubscriptionTests
//
//  Created by David Lee on 11/21/22.
//

import ComposableArchitecture
import XCTest
@testable import Subscription

@MainActor
final class SubscriptionTests: XCTestCase {
  func testSubscriptionID() async {
    let store = TestStore(
      initialState: Verification.State(),
      reducer: Verification()
    )
    
    await store.send(.set(\.$subscriptionID, "")) {
      $0.isVerifyButtonDisabled = true
      $0.prompt = "Subscription ID is Empty"
    }
    
    await store.send(.set(\.$subscriptionID, "123")) {
      $0.isVerifyButtonDisabled = false
      $0.prompt = ""
      $0.subscriptionID = "123"
    }
  }
  
  func testVerifyReceiptButton() async {
    let store = TestStore(
      initialState: Verification.State(),
      reducer: Verification()
    )
    
    await store.send(.verifyButtonTapped) {
      if $0.isVerifyButtonDisabled {
        $0.prompt = "Subscription ID is Empty"
      }
    }
  }
}

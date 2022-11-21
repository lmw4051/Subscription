//
//  Screen.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI
import ComposableArchitecture

struct Screen: ReducerProtocol {
  enum State: Equatable {
    case verification(Verification.State)
  }
  
  enum Action {
    case verification(Verification.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Scope(state: /State.verification, action: /Action.verification) {
      Verification()
    }
  }
}

//
//  AppDelegate.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import Foundation
import ComposableArchitecture

struct AppViewDelegate: ReducerProtocol {
  struct State:Equatable {}
  
  enum Action: Equatable {
    case didFinishLaunching
  }
  
  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .didFinishLaunching:
      return .none
    }
  }
}

//
//  AppView.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI
import ComposableArchitecture

struct Root: ReducerProtocol {
  struct State: Equatable {
    var appViewDelegate: AppViewDelegate.State
    var coordinator: Coordinator.State
    
    static let initialState = Root.State(
      appViewDelegate: .init(),
      coordinator: .initialState
    )
  }
  
  enum Action {
    case appViewDelegate(AppViewDelegate.Action)
    case coordinator(Coordinator.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Scope(state: \State.appViewDelegate, action: /Action.appViewDelegate) {
      AppViewDelegate()
    }
    Scope(state: \State.coordinator, action: /Action.coordinator) {
      Coordinator()
    }
    Reduce { state, action in
      switch action {
      case .appViewDelegate(.didFinishLaunching):
        return .none
      case .coordinator:
        return .none
      }
    }
  }
}

struct RootView: View {
  let store: StoreOf<Root>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      CoordinatorView(
        store: self.store.scope(
          state: \Root.State.coordinator,
          action: Root.Action.coordinator
        )
      )
    }
  }
}

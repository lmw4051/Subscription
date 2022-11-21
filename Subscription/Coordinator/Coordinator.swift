//
//  Coordinator.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct Coordinator: ReducerProtocol {
  struct State: Equatable, IndexedRouterState {
    static let initialState = Coordinator.State(
      routes: [.root(.verification(.init()), embedInNavigationView: true)]
    )
    var routes: [Route<Screen.State>]
  }
  
  enum Action: IndexedRouterAction {
    case routeAction(Int, action: Screen.Action)
    case updateRoutes([Route<Screen.State>])
  }
  
  @ReducerBuilder<State, Action>
  var core: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      .none
    }
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce(
      AnyReducer(Screen())
        .forEachIndexedRoute(environment: { () })
        .withRouteReducer(AnyReducer(core)),
      environment: ()
    )
  }
}

struct CoordinatorView: View {
  let store: Store<Coordinator.State, Coordinator.Action>
  
  var body: some View {
    TCARouter(self.store) { screen in
      Group {
        SwitchStore(screen) {
          CaseLet(
            state: /Screen.State.verification,
            action: Screen.Action.verification,
            then: VerificationView.init
          )
          Default {}
        }
      }
    }
  }
}

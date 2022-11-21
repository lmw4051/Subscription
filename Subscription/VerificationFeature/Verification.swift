//
//  Verification.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI
import ComposableArchitecture

struct Verification: ReducerProtocol {
  struct State: Equatable {
    
  }
  
  enum Action: Equatable {
    
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
        .none
    }
  }
}

struct VerificationView: View {
  let store: StoreOf<Verification>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      ZStack {
        if UIDevice.current.userInterfaceIdiom == .phone {
          VStack(spacing: 0) {
            VerificationTopView()
            Spacer()
          }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
          ZStack {
            VStack(spacing: 0) {
              VerificationTopView()
              
              Spacer()
                .frame(height: Defaults.screenSize.height * 0.5)
            }
          }
        }
      }
      .background(.black)
      .preferredColorScheme(.dark)
    }
  }
}

#if DEBUG
struct VerificationView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VerificationView(
        store: Store(
          initialState: Verification.State(),
          reducer: Verification()
        )
      )
    }
  }
}
#endif



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
              .frame(height: 15.38)
                        
            VStack(spacing: 24) {
              VerificationTitle(text: "Subscription Verification")
            }
            .padding([.leading, .trailing], 24)
            
            Spacer()
          }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
          ZStack {
            VStack(spacing: 0) {
              VerificationTopView()
              
              Spacer()
                .frame(height: Defaults.screenSize.height * 0.5)
            }
            
            VStack(spacing: 24) {
              Spacer()
                .frame(height: 16)
              
              VerificationTitle(text: "Subscription Verification")
                .padding(.leading, 24)
            }
            .padding(
              [.leading, .trailing],
              Defaults.screenSize.width * 0.2
            )
            .offset(y: 80)
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



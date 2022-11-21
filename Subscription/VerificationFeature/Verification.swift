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
    @BindableState var isSubscriptionTFFocused = false
    @BindableState var subscriptionID: String = ""
    var isVerifyButtonDisabled = true
  }
  
  enum Action: BindableAction, Equatable {
    case binding(BindingAction<Verification.State>)
  }
  
  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding(\.$subscriptionID):
        if state.subscriptionID == "" {
          state.isVerifyButtonDisabled = true
        } else {
          state.isVerifyButtonDisabled = false
        }
        return .none
        
      case .binding:
        return .none
      }
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
              
              VerificationTextField(
                fieldName: "Subscription ID",
                text: viewStore.binding(\.$subscriptionID),
                focused: viewStore.binding(\.$isSubscriptionTFFocused)
              )
              .autocapitalization(.none)
              .disableAutocorrection(true)
              
              VerificationButton(store: self.store, text: "Verify")              
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
              
              HStack(spacing: 24) {
                VerificationTextField(
                  fieldName: "Subscription ID",
                  text: viewStore.binding(\.$subscriptionID),
                  focused: viewStore.binding(\.$isSubscriptionTFFocused)
                )
                .frame(
                  width: Defaults.screenSize.width * 0.44
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                VerificationButton(store: self.store, text: "Verify")
                  .frame(
                    width: Defaults.screenSize.width * 0.11
                  )
                  .onTapGesture {
                    self.endEditing()
                  }
              }
              .frame(height: Defaults.verifyButtonHeight)
              .padding([.leading, .trailing], 24)
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
    .onTapGesture {
      self.endEditing()
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

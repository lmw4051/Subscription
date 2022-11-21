//
//  VerificationButton.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI
import ComposableArchitecture

struct VerificationButton: View {
  let store: StoreOf<Verification>
  let text: String
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      Button {
        if !viewStore.isVerifyButtonDisabled {
          viewStore.send(.callVerifyReceiptAPI)
        }
        hideKeyboard()
      } label: {
        Text(text)
          .font(.custom("Rubik-Regular", size: 20))
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .frame(height: Defaults.verifyButtonHeight)
          .cornerRadius(4)
          .background(Color.verifyButtonColor)
          .disabled(viewStore.isVerifyButtonDisabled)
      }
      .onTapGesture {
        self.endEditing()
      }
    }
  }
}

struct VerificationButton_Previews: PreviewProvider {
  static var previews: some View {
    VerificationButton(
      store: Store(
        initialState: Verification.State(),
        reducer: Verification()
      ),
      text: ""
    )
  }
}

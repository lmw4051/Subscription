//
//  VerificationTextField.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI

struct VerificationTextField: View {
  var fieldName: String
  @Binding var text: String
  @Binding var focused: Bool
  @FocusState private var isFocused: Bool
  
  var body: some View {
    TextField("", text: $text)
      .font(.custom("Rubik-Regular", size: 17))
      .foregroundColor(.white)
      .placeholder(when: text.isEmpty) {
        Text(fieldName)
          .font(.custom("Rubik-Regular", size: 17))
          .foregroundColor(.white.opacity(0.2))
      }
      .keyboardType(.numberPad)
      .autocapitalization(.none)
      .foregroundColor(.white)
      .focused($isFocused)
      .frame(height: Defaults.subscriptionTextFieldHeight)
      .modifier(CustomTextFieldBorderedViewModifier())
  }
}

struct VerificationTextField_Previews: PreviewProvider {
  static var previews: some View {
    VerificationTextField(
      fieldName: "",
      text: .constant(""),
      focused: .constant(false)
    )
  }
}

//
//  CustomTextFieldBorderedViewModifier.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI

struct CustomTextFieldBorderedViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(
        EdgeInsets(
          top: 16,
          leading: 16,
          bottom: 16,
          trailing: 16
        )
      )
      .background(.white.opacity(0.15))
      .overlay(
        RoundedRectangle(cornerRadius: 4)
          .stroke(lineWidth: 1)
          .foregroundColor(.white.opacity(0.2))
      )
  }
}

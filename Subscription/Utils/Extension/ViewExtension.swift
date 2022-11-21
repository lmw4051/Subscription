//
//  ViewExtension.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI

enum Device {
  enum Devicetype {
    case iphone, ipad, mac
  }
  
  static var deviceType: Devicetype {
    #if os(macOS)
      return .mac
    #else
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .ipad
    } else {
      return .iphone
    }
    #endif
  }
}

extension View {
  @ViewBuilder func ifIs<T>(
    _ condition: Bool,
    transform: (Self) -> T
  ) -> some View where T: View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
  
  @ViewBuilder func ifElse<T: View, V: View>(
    _ condition:Bool,
    isTransform:(Self) -> T, elseTransform: (Self) -> V
  ) -> some View {
    if condition {
      isTransform(self)
    } else {
      elseTransform(self)
    }
  }
  
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
      ZStack(alignment: alignment) {
        placeholder().opacity(shouldShow ? 1 : 0)
        self
      }
    }
  
  func endEditing() {
    UIApplication.shared.endEditing()
  }
  
  func hideKeyboard() {
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil,
      from: nil,
      for: nil
    )
  }
}

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

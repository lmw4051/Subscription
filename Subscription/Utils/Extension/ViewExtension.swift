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
}
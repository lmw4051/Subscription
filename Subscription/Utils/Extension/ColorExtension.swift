//
//  ColorExtension.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI

extension Color {
  public static let verifyButtonColor = Color(hex: "#FF3557", alpha: 1.0)  
  
  init(hex: String, alpha: CGFloat = 1.0) {
    var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    
    if hex.hasPrefix("#") {
      hex = String(hex.dropFirst())
    }
    
    assert(hex.count == 3 || hex.count == 6 || hex.count == 8, "Invalid hex code used. hex count is #(3, 6, 8).")
    
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let red, green, blue: UInt64
    
    switch hex.count {
    case 3: // RGB (12-bit)
      (red, green, blue) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (red, green, blue) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (red, green, blue) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (red, green, blue) = (1, 1, 0)
    }
    
    self.init(
      .sRGB,
      red: Double(red) / 255,
      green: Double(green) / 255,
      blue: Double(blue) / 255,
      opacity: Double(alpha)
    )
  }
}

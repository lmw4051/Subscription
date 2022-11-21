//
//  PromptText.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI

struct PromptText: View {
  var text: String
  
  var body: some View {
    Text(text)
      .foregroundColor(.red)
      .fixedSize(horizontal: false, vertical: true)
      .font(.caption)
  }
}

struct PromptText_Previews: PreviewProvider {
  static var previews: some View {
    PromptText(text: "")
  }
}

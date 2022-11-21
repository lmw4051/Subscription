//
//  VerificationTitle.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI

struct VerificationTitle: View {
  let text: String
  
  var body: some View {
    HStack {
      Text(text)
        .frame(height: 27.26)
        .font(.custom("Rubik-Light", size: 23))
        .foregroundColor(.white)
      
      Spacer()
    }
  }
}

struct VerificationTitle_Previews: PreviewProvider {
  static var previews: some View {
    VerificationTitle(text: "")
  }
}

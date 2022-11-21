//
//  VerificationLoadingView.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI

struct VerificationLoadingView: View {
  var body: some View {
    HStack(spacing: 4) {
      LottieView(
        lottieFile: "Noted-Loading",
        loopMode: .loop
      )
      .frame(
        width: Defaults.lottieViewSize,
        height: Defaults.lottieViewSize
      )

      Text("Verifying...")
        .font(.custom("Rubik-Regular", size: 20))
        .foregroundColor(.white)
    }
  }
}

struct VerificationLoadingView_Previews: PreviewProvider {
  static var previews: some View {
    VerificationLoadingView()
  }
}

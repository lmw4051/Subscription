//
//  VerificationTopView.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI

struct VerificationTopView: View {
  var body: some View {
    Image("verification-space")
      .resizable()
      .ifIs(Device.deviceType == .iphone) {
        $0
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
      }
      .ifIs(Device.deviceType == .ipad) {
        $0
          .aspectRatio(contentMode: .fit)
          .frame(
            width: Defaults.screenSize.width * 0.75,
            height: Defaults.screenSize.width * 0.75 / 1.55
          )
      }
      .overlay(
        Image("Noted")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .ifIs(Device.deviceType == .iphone) {
            $0
              .frame(
                width: Defaults.screenSize.width * 0.18,
                height: Defaults.screenSize.width * 0.18
              )
          }
          .ifIs(Device.deviceType == .ipad) {
            $0
              .frame(
                width: Defaults.screenSize.width * 0.104,
                height: Defaults.screenSize.width * 0.104
              )
          },
        alignment: .center
      )
      .overlay(
        Image("verification-astronaut")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .ifIs(Device.deviceType == .iphone) {
            $0
              .frame(
              width: Defaults.screenSize.width * 0.68,
              height: Defaults.screenSize.width * 0.68 / 1.605
            )
          }
          .ifIs(Device.deviceType == .ipad) {
            $0
              .frame(
                width: Defaults.screenSize.width * 0.4,
                height: Defaults.screenSize.width * 0.4 / 1.6
              )
          }
          .rotationEffect(.degrees(4))
          .ifIs(Device.deviceType == .iphone) {
            $0
              .offset(x: -60, y: 40)
          }
          .ifIs(Device.deviceType == .ipad) {
            $0
              .offset(x: -100, y: 60)
          }
      )
  }
}

struct VerificationTopView_Previews: PreviewProvider {
  static var previews: some View {
    VerificationTopView()
  }
}

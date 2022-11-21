//
//  CustomAlert.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI
import ComposableArchitecture

struct CustomAlert: ReducerProtocol {
  struct State: Equatable {
    var showAlert: Bool = false
    var isValid: Bool = false
  }
  
  enum Action: Equatable {
    case doneButtonTapped
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .doneButtonTapped:
        state.showAlert = false
        return .none
      }
    }
  }
}

struct CustomAlertView: View {
  let store: StoreOf<CustomAlert>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      if viewStore.showAlert {
        ZStack {
          Color.black
            .opacity(viewStore.showAlert ? 0.8 : 0)
            .ignoresSafeArea()
            .onTapGesture {
              viewStore.send(.doneButtonTapped)
            }
          
          ZStack {
            Color
              .alertBgColor
              .ifIs(Device.deviceType == .iphone) {
                $0
                  .frame(
                    width: Defaults.screenSize.width * 0.8,
                    height: Defaults.screenSize.width * 0.8 / 1.08
                  )
              }
              .ifIs(Device.deviceType == .ipad) {
                $0
                  .frame(
                    width: Defaults.screenSize.width * 0.3,
                    height: Defaults.screenSize.width * 0.3 / 1.08
                  )
              }
              .cornerRadius(20)
            
            if viewStore.isValid {
              Image("Planet")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ifIs(Device.deviceType == .iphone) {
                  $0
                    .frame(
                      width: Defaults.screenSize.width * 0.76,
                      height: Defaults.screenSize.width * 0.76 / 1.05
                    )
                }
                .ifIs(Device.deviceType == .ipad) {
                  $0
                    .frame(
                      width: Defaults.screenSize.width * 0.25,
                      height: Defaults.screenSize.width * 0.25 / 1.05
                    )
                }
                .overlay(
                  Image(systemName: "checkmark")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .ifIs(Device.deviceType == .iphone) {
                      $0
                        .frame(
                          width: Defaults.screenSize.width * 0.085,
                          height: Defaults.screenSize.width * 0.085 / 1.085
                        )
                        .offset(y: -18)
                    }
                    .ifIs(Device.deviceType == .ipad) {
                      $0
                        .frame(
                          width: Defaults.screenSize.width * 0.03,
                          height: Defaults.screenSize.width * 0.03 / 1.085
                        )
                        .offset(y: -18)
                    },
                  alignment: .center
                )
                .ifIs(Device.deviceType == .iphone) {
                  $0
                    .offset(y: -50)
                }
                .ifIs(Device.deviceType == .ipad) {
                  $0
                    .offset(y: -50)
                }
                .rotationEffect(.degrees(-2.56))
            } else {
              Circle()
                .strokeBorder(
                  Color.alertInvalidColor,
                  lineWidth: 1
                )
                .ifIs(Device.deviceType == .iphone) {
                  $0
                    .frame(
                      width: Defaults.screenSize.width * 0.23,
                      height: Defaults.screenSize.width * 0.23
                    )
                }
                .ifIs(Device.deviceType == .ipad) {
                  $0
                    .frame(
                      width: Defaults.screenSize.width * 0.075,
                      height: Defaults.screenSize.width * 0.075
                    )
                }
                .overlay(
                  Image(systemName: "xmark")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.alertInvalidColor),
                  alignment: .center
                )
                .ifIs(Device.deviceType == .iphone) {
                  $0
                    .offset(y: -70)
                }
                .ifIs(Device.deviceType == .ipad) {
                  $0
                    .offset(y: -70)
                }
            }
                                    
            VStack(spacing: 0) {
              Spacer()
                .ifIs(Device.deviceType == .iphone) {
                  $0
                    .frame(height: Defaults.screenSize.width * 0.8 / 1.08 * 0.58)
                }
                .ifIs(Device.deviceType == .ipad) {
                  $0
                    .frame(height: Defaults.screenSize.width * 0.3 / 1.08 * 0.58)
                }
              
              Text(viewStore.isValid ? "Valid" : "Invalid")
                .font(.custom("Rubik-Regular", size: 28))
                .foregroundColor(.white)
              
              Spacer()
                .ifIs(Device.deviceType == .iphone) {
                  $0
                    .frame(height: Defaults.screenSize.width * 0.8 / 1.08 * 0.1)
                }
                .ifIs(Device.deviceType == .ipad) {
                  $0
                    .frame(height: Defaults.screenSize.width * 0.3 / 1.08 * 0.1)
                }
              
              Divider()
                .ifIs(Device.deviceType == .iphone) {
                  $0
                    .frame(width: Defaults.screenSize.width * 0.8)
                }
                .ifIs(Device.deviceType == .ipad) {
                  $0
                    .frame(width: Defaults.screenSize.width * 0.3)
                }
                .frame(height: 1)
                .background(.white.opacity(0.2))
              
              Button {
                viewStore.send(.doneButtonTapped)
              } label: {
                Text("Done")
                  .ifIs(Device.deviceType == .iphone) {
                    $0
                      .frame(height: Defaults.screenSize.width * 0.8 / 1.08 * 0.22)
                  }
                  .ifIs(Device.deviceType == .ipad) {
                    $0
                      .frame(height: Defaults.screenSize.width * 0.3 / 1.08 * 0.25)
                  }
                  .font(.custom("Rubik-Light", size: 20))
                  .foregroundColor(.alertDoneBtnColor)
              }
            }
          }
        }
      }
    }
  }
}

#if DEBUG
struct CustomAlertView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CustomAlertView(
        store: Store(
          initialState: CustomAlert.State(),
          reducer: CustomAlert()
        )
      )
    }
  }
}
#endif

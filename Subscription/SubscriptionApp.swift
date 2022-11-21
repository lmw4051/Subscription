//
//  SubscriptionApp.swift
//  Subscription
//
//  Created by David Lee on 11/21/22.
//

import SwiftUI
import ComposableArchitecture

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: .initialState,
    reducer: Root()
  )
  
  lazy var viewStore = ViewStore(
    self.store.scope(state: { _ in () }),
    removeDuplicates: ==
  )
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    self.viewStore.send(.appViewDelegate(.didFinishLaunching))
    return true
  }
}

@main
struct SubscriptionApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
  var body: some Scene {
    WindowGroup {
      RootView(store: self.appDelegate.store)
    }
  }
}

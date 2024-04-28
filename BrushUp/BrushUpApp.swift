//
//  BrushUpApp.swift
//  BrushUp
//
//  Created by John Sims on 4/16/24.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseConfiguration.shared.setLoggerLevel(.debug)
    FirebaseApp.configure()
    return true
  }
}

@main
struct MyApp: App {
    @StateObject var viewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if viewModel.isAuthenticated {
                ContentView()
                    .environmentObject(viewModel)
            } else {
                AuthView()
                    .environmentObject(viewModel)
            }
        }
    }
}


#Preview {
    ContentView()
}

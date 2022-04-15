//
//  JPLL2_0App.swift
//  JPLL2.0
//
//  Created by Sarah Jaysmith on 2022-03-28.
//

import SwiftUI
import Firebase

@main
struct JPLL2_0App: App {
    
    @StateObject private var networkController = NetworkController()

    init() {
        FirebaseApp.configure()
      }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            //TestView()
            StartView()
                .environmentObject(viewModel)
                .environmentObject(NetworkController())
        }
    }
}

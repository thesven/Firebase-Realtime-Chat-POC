//
//  RealTimeChat_FirebaseApp.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-23.
//

import SwiftUI
import Firebase

@main
struct RealTimeChat_FirebaseApp: App {
    
    init(){
        setupFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private extension RealTimeChat_FirebaseApp {
    func setupFirebase() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
}

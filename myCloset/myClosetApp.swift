//
//  myClosetApp.swift
//  myCloset
//
//  Created by Jonah Gloss on 2/14/23.
//

import SwiftUI
import Firebase


@main
struct myClosetApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}

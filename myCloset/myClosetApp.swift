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
    @StateObject var clothingItemManager = ClothingItemManager()
    @StateObject var selectedItemsManager = SelectedItemsManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(clothingItemManager)
                .environmentObject(selectedItemsManager)
        }
    }
}

//
//  MenuItem.swift
//  myCloset
//
//  Created by Michael Emborsky on 3/26/23.
//

import Foundation
import SwiftUI

struct MainMenuItem: Identifiable {
    var id: UUID
    var icon: String
    var text: String
    var view: AnyView
//    var view: any View
    
    

    public func getIcon() -> String {
        return self.icon
    }
    
    
}

let items: [MainMenuItem] = [
    MainMenuItem(id: UUID(), icon: "house", text: "Home", view: AnyView(FeedView())),
    MainMenuItem(id: UUID(), icon: "magnifyingglass", text: "Search", view: AnyView(FeedView())),
    MainMenuItem(id: UUID(), icon: "door.sliding.left.hand.closed", text: "myCloset", view: AnyView(ClosetView())),
    MainMenuItem(id: UUID(), icon: "person.circle.fill", text: "myProfile", view: AnyView(FeedView())),
]


